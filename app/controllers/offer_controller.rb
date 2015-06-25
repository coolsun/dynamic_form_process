class OfferController < ApplicationController

  def offer_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("offer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = params[:procedure_id].to_i
    location_list = []
    role_list = []
    if is_admin || is_hiring_mgr(procedure_id)
      logger.info "==get_mgr_rank_list = admin=="
      location_list = Location.where(:procedure_id => procedure_id)
      role_list = Role.where(:procedure_id => procedure_id)
    else
      logger.info "==get_mgr_rank_list = mgrs=="
      location_list = Location.where(:procedure_id => procedure_id, :id => current_user_location_mgr_location_ids)
      role_list = Role.where(:procedure_id => procedure_id, :id => current_user_role_mgr_role_ids)
    end

    locations  = params[:locations].kind_of?(Array)  && params[:locations].present?  ? params[:locations]  : location_list.pluck(:id)
    roles      = params[:roles].kind_of?(Array)      && params[:roles].present?      ? params[:roles]      : role_list.pluck(:id)

    filter_options = {
      :is_admin => is_admin,
      :locations => locations,
      :roles => roles,
    }
    offer_list, offers_total = Position.get_offer_list(rsas_table_params, filter_options, params[:sub_step])

    render :json => {
      :success => true,
      :now => params[:page],
      :total => offers_total,
      :show => offer_list,
      :permission_to_active => permission_to_active,
      :show_import_offer_page => check_user_permission("import_pre_offered_applicants_by_xlsx")[0],
      :location_list => location_list,
      :role_list => role_list,
    }
  end

  def pre_offer_applicants
    permission_to_show, permission_to_active, permission_message = check_user_permission("offer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    position = Position.find_by_id(params[:offer][:position_id])
    procedure_id = position.procedure_id
    if position
      offered_application_ids = Application.where(:position_id => position.id, :offered => (params[:sub_step] == "offer" ? "offered" : "post_offered")).pluck(:id)
      vacancy = position.vacancy - offered_application_ids.length
      not_offered_application_ids = (params[:offer][:application_ids].split(",") - offered_application_ids)[0..vacancy]

      pre_offer_fail_list, can_offer_user_ids = Application.pre_offer_fail_list(Application.where(:id => not_offered_application_ids).pluck(:user_id), position.id, procedure_id, params[:sub_step])

      old_math_applications = Application.where(:position_id => position.id, :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"))

      if params[:sub_step] == "offer"
        has_offered_user_ids = Application.includes(:position).where(:offered => "post_offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
      else
        has_offered_user_ids = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
      end

      not_submit_has_offered_and_disqualify_user = (Applicant.where(:procedure_id => position.procedure_id, :disqualify => true).pluck(:user_id) + has_offered_user_ids +
                                                    Applicant.where(:procedure_id => position.procedure_id, :application_submit_at => nil).pluck(:user_id)).uniq

      Application.includes(:user).where(:position_id => position.id).where.not(:offered => ["offered", "post_offered"]).update_all(:offered => "wait")

      if Application.where(:position_id => position.id, :user_id => can_offer_user_ids).update_all(:offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"))
        applicants = []
        Application.includes(:user).where(:position_id => position.id).each do |application|
          next if not_submit_has_offered_and_disqualify_user.include?(application.user_id)
          next if params[:sub_step] == 'offer' && /post/.match(application.offered)
          next if params[:sub_step] != 'offer' && !(/post|wait|pre_offered/.match(application.offered))
          applicants << {
            :application_id => application.id,
            :name => application.user.name,
            :pre_offered => (params[:sub_step] == "offer" ? ["pre_offered", "offered"].include?(application.offered) : ["post_pre_offered", "post_offered"].include?(application.offered)),
            :offered => application.offered,
            :auto_match => application.auto_match,
            :offer_accept => application.offer_accept
          }
        end
        render :json => {
          :success => true,
          :msg => "The offer has been updated successfully.",
          :pre_offer_fail_list => pre_offer_fail_list,
          :applicants => applicants.sort{ |a, b| a[:name].downcase <=> b[:name].downcase }
        } and return
      else
        if old_math_applications
          Application.where(:position_id => position.id, :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered")).update_all(:offered => "wait")
          old_math_applications.each do |application|
            application.offered = (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered")
            application.save!
          end
        end
      end
    end
    render :json => {:success => false, :msg => "Failed to update the offer."}
  end

  def offer_all_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("offer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = params[:current_process_id].to_i
    first_step_offered_user_ids = []
    if params[:sub_step] == "offer"
      has_offered_user_ids = Application.includes(:position).where(:offered => "post_offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
    else
      has_offered_user_ids = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
    end
    # applicant must submit and not disqualify
    not_submit_has_offer_and_disqualify_user = (Applicant.where(:procedure_id => procedure_id, :disqualify => true).pluck(:user_id) + has_offered_user_ids +
                                                Applicant.where(:procedure_id => procedure_id, :application_submit_at => nil).pluck(:user_id)).uniq

    position_id = Position.find_by_id(params[:position_id]).id
    applicants = []
    user_ids = User.includes(:applicants).where(:applicants =>{:procedure_id => procedure_id}).where.not(:id => not_submit_has_offer_and_disqualify_user).pluck(:id)
    users = User.includes(:applications).where(:id => user_ids, :applications => {:position_id => position_id}).order("LOWER(first_name)")
    users.each do |user|
      if user.applications.present?
        applicants << {
          :user_id => user.id,
          :name => user.name,
          :offered => user.applications.first.offered,
          :pre_offered => ["pre_offered", "post_pre_offered", "offered", "post_offered"].include?(user.applications.first.offered),
          :offer_accept => user.applications.first.offer_accept
        }
      else
        applicants << {
          :user_id => user.id,
          :name => user.name,
          :offered => 'wait',
          :pre_offered => false,
          :offer_accept => nil
        }
      end

    end
    #logger.info "== #{applicants}=="
    if applicants
      render :json => {:success => true, :applicants => applicants}
    else
      render :json => {:success => false}
    end
  end

  def pre_offer_all
    permission_to_show, permission_to_active, permission_message = check_user_permission("offer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    position = Position.find_by_id(params[:offer][:position_id])
    procedure_id = position.procedure_id
    if params[:sub_step] == "offer"
      offered_application_ids = Application.where(:position_id => position.id, :offered => "offered").pluck(:id)
    else
      offered_application_ids = Application.where(:position_id => position.id, :offered => "post_offered", :offer_accept => 'accepted').pluck(:id)
    end
    vacancy = position.vacancy - offered_application_ids.length
    if position
      pre_offer_application_ids = []
      search_user_ids = (params[:offer][:applicants].split(",") - offered_application_ids)[0..vacancy]

      pre_offer_fail_list, can_offer_application_ids = Application.pre_offer_fail_list(search_user_ids, position.id, procedure_id, params[:sub_step])

      User.includes(:applications).where(:id => can_offer_application_ids).each do |user|
        result_application = user.applications.select { |application| application.position_id == position.id }.first
        if result_application.blank?
          result_application = Application.create(:position_id => position.id, :user_id => user.id, :user_rank => 99999, :mgr_rank => 99999, :offered => "wait")
        end
        pre_offer_application_ids << result_application.id
      end
      old_math_applications = Application.where(:position_id => position.id, :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"))

      if params[:sub_step] == "offer"
        has_offered_user_ids = Application.includes(:position).where(:offered => "post_offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
      else
        has_offered_user_ids = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure_id}).pluck(:user_id)
      end

      not_submit_has_offered_and_disqualify_user = (Applicant.where(:procedure_id => procedure_id, :disqualify => true).pluck(:user_id) + has_offered_user_ids +
                                                    Applicant.where(:procedure_id => procedure_id, :application_submit_at => nil).pluck(:user_id)).uniq

      Application.includes(:user).where(:position_id => position.id).where.not(:offered => (["offered", "post_offered"])).update_all(:offered => "wait")

      if Application.where(:position_id => position.id, :id => pre_offer_application_ids).update_all(:offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"))
        applicants = []
        Application.includes(:user).where(:position_id => position.id).each do |application|
          next if not_submit_has_offered_and_disqualify_user.include?(application.user_id)
          next if params[:sub_step] == 'offer' && /post/.match(application.offered)
          next if params[:sub_step] != 'offer' && !(/post|wait|pre_offered/.match(application.offered))
          applicants << {
            :application_id => application.id,
            :name => application.user.name,
            :pre_offered => (params[:sub_step] == "offer" ? ["pre_offered", "offered"].include?(application.offered) : ["post_pre_offered", "post_offered"].include?(application.offered)),
            :offered => application.offered,
            :auto_match => application.auto_match,
            :offer_accept => application.offer_accept
          }
        end
        render :json => {
          :success => true,
          :msg => "Offer all has been updated successfully.",
          :pre_offer_fail_list => pre_offer_fail_list,
          :applicants => applicants.sort{ |a, b| a[:name].downcase <=> b[:name].downcase }
        } and return
      else
        if old_math_applications
          Application.where(:position_id => position.id, :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered")).update_all(:offered => "wait")
          old_math_applications.each do |application|
            application.offered = (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered")
            application.save!
          end
        end
      end
    end
    render :json => {:success => false, :msg => "Failed to update the offer all."}
  end

  def position_pre_offered_list
    offered_applicants = Application.where(:position_id => params[:position_id], :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"))
    if offered_applicants
      render :json => {:success => true, :applicants => offered_applicants.as_json(:include => {:user => {:methods => :name, :only => [:email]}})}
    else
      render :json => {:success => false}
    end
  end

  def offer_mail_template
    mail_template = EmailTemplate.where(:email_type => "offer_email", :procedure_id => params[:current_process_id], :is_active => true).first
    if mail_template
      render :json => {:success => true, :mail_template => mail_template}
    else
      render :json => {:success => false}
    end
  end

  def send_offered_email
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_offered_email")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    begin
      if params[:email_info][:recipients].present?
        recipients = params[:email_info][:recipients].collect{|obj| obj[:email]}
        user_ids = User.where(:email => params[:email_info][:recipients].collect{|obj| obj[:email]}).pluck(:id)  #match user email
        # only pre_offered applicant, can send email
        applicants = Application.includes(:user).where(:position_id => params[:position_id], :offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"), :user_id => user_ids)
        recipients = applicants.collect{|applicant| applicant.user.email}

        admin_emails = User.where(:is_admin => true).pluck(:email)
        procedure = Procedure.find_by_id(params[:current_process_id])
        positions = Position.includes(:role, :location).where(:id => params[:position_id])
        step = ProcedureSubStep.joins(:procedure_step).where(:identify_name => (params[:sub_step] == "offer" ? "offer" : "post_offer_offer"), :procedure_steps => {:procedure_id => procedure.id}).first
        bcc = Procedure.admin_and_hiring_mgr_emails(params[:current_process_id]) + (params[:email_info][:bcc] ? params[:email_info][:bcc].collect{|obj| obj["email"]} : [])
        cc = params[:email_info][:cc] ? params[:email_info][:cc].collect{|obj| obj["email"]} : []
        recipients.each do |recipient|
          user = User.find_by_email(recipient)
          subject = EmailTemplate.replace_keyworld(params[:email_info][:subject], procedure, positions, step, user, admin_emails)
          content = EmailTemplate.replace_keyworld(params[:email_info][:content], procedure, positions, step, user, admin_emails)
          StanfordMailer.send_shipped(recipient, subject, content, bcc, cc)
        end
        applicants.update_all(:offered => (params[:sub_step] == "offer" ? "offered" : "post_offered")) if applicants
      end
      applicants = []

      if params[:sub_step] == "offer"
        has_offered_user_ids = Application.includes(:position).where(:offered => "post_offered", :positions => {:procedure_id => procedure.id}).pluck(:user_id)
      else
        has_offered_user_ids = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure.id}).pluck(:user_id)
      end

      not_submit_has_offer_and_disqualify_user = (Applicant.where(:procedure_id => procedure.id, :disqualify => true).pluck(:user_id) + has_offered_user_ids +
                                                  Applicant.where(:procedure_id => procedure.id, :application_submit_at => nil).pluck(:user_id)).uniq

      Application.includes(:user).where(:position_id => params[:position_id]).each do |application|
        next if not_submit_has_offer_and_disqualify_user.include?(application.user_id)
        applicants << {
          :application_id => application.id,
          :name => application.user.name,
          :pre_offered => (params[:sub_step] == "offer" ? ["pre_offered", "offered"].include?(application.offered) : ["post_pre_offered", "post_offered"].include?(application.offered)),
          :offered => application.offered,
          :auto_match => application.auto_match,
          :offer_accept => application.offer_accept
        }
      end
      render :json => {:success => true, :msg => "Email delivery successfully.", :applicants => applicants.sort{ |a, b| a[:name].downcase <=> b[:name].downcase }}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Email delivery failed."}
    end
  end

  def user_offer_list
    if params[:sub_step] == "offer"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Offer Status")
    elsif params[:sub_step] == "post_offer_offer"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Post Match Offer Status")
    end

    procedure_id = params[:current_process_id].to_i
    applications = Application.includes({:position => [:location, :role]}, :user).where(:user_id => session[:user_id], :positions => {:procedure_id => procedure_id})
    offers = []
    selected = false
    applications.each do |application|
      if params[:sub_step] == 'offer'
        selected = true if (application.offered == 'offered') && application.offer_accept
      else
        selected = true if (application.offered == 'post_offered') && application.offer_accept
      end
      offers << {
        "position_id" => application.position_id,
        "offered" => application.offered,
        "offer_accept" => application.offer_accept,
        "position_name" => application.position.name,
        "offer_msg" => application.offer_msg(params[:sub_step]),
      }
    end

    render :json => {
      :permission_to_active => permission_to_active,
      :offer => offers,
      :selected => selected
    }
  end

  def offer_confirm
    if params[:sub_step] == "offer"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Offer Status")
    elsif params[:sub_step] == "post_offer_offer"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Post Match Offer Status")
    end
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    offered_applicant = Application.where(:position_id => params[:position_id], :user_id => current_user.id, :offered => (params[:sub_step] == "offer" ? "offered" : "post_offered")).first
    if offered_applicant.present?
      offered_applicant.update(:offer_accept => (params[:attitude] ? "accepted" : "rejected"))
      identify_name = params[:attitude] ? "offer_status_accept" : "offer_status_decline"
      success_html = SystemMessage.where(:procedure_id => params[:current_process_id], :identify_name => identify_name).first.message
      offered_applicant =  {
        "position_id" => offered_applicant.position_id,
        "offered" => offered_applicant.offered,
        "offer_accept" => offered_applicant.offer_accept,
        "position_name" => offered_applicant.position.name,
        "offer_msg" => offered_applicant.offer_msg(params[:sub_step]),
      }
      render :json => {:success => true, :permission_to_active => !params[:attitude], :msg => "The result has been submitted successfully.", :offer => offered_applicant, :success_html => success_html}
    else
      render :json => {:success => false, :msg => "Failed to submit the result."}
    end
  end

  def quick_send_offer_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_offered_email")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    position_ids = params[:positions]
    wait_offers = Position.includes(:role, :location, :applications)
                          .where(:id => position_ids, :applications => {:offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"), :offer_accept => nil})

    recipients = []
    wait_offers.each do |offer|
      offer.applications.each do |application|
        user = User.find_by_id(application.user_id)
        recipients << {
          "name" =>  user.name,
          "email" => user.email,
          "is_constant" => true
        }
      end
    end
    render :json => {:success => true, :msg => "Get Email Success.", :recipients => recipients}
  end

  def quick_send_offer
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_offered_email")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure = Procedure.find_by_id(params[:current_process_id])
    position_ids = params[:positions]
    wait_offers = Position.includes(:role, :location, :applications).where(:id => position_ids, :applications => {:offered => (params[:sub_step] == "offer" ? "pre_offered" : "post_pre_offered"), :offer_accept => nil})
    admin_emails = User.where(:is_admin => true).pluck(:email)
    step = ProcedureSubStep.joins(:procedure_step).where(:identify_name => (params[:sub_step] == "offer" ? "offer" : "post_offer_offer"), :procedure_steps => {:procedure_id => procedure.id}).first
    mail_template = EmailTemplate.where(:email_type => "offer_email", :procedure_id => procedure.id, :is_active => true).first
    bcc = Procedure.admin_and_hiring_mgr_emails(procedure.id) + (params[:email_info][:bcc] ? params[:email_info][:bcc].collect{|obj| obj["email"]} : [])
    cc = params[:email_info][:cc] ? params[:email_info][:cc].collect{|obj| obj["email"]} : []
    begin
      wait_offers.each do |offer|
        offer.applications.each do |application|
          user = User.find_by_id(application.user_id)
          positions = Position.includes(:role, :location).where(:id => offer.id)
          subject = EmailTemplate.replace_keyworld(params[:email_info][:subject], procedure, positions, step, user, admin_emails)
          content = EmailTemplate.replace_keyworld(params[:email_info][:content], procedure, positions, step, user, admin_emails)
          StanfordMailer.send_shipped(user.email, subject, content, bcc, cc)
          application.update(:offered => (params[:sub_step] == "offer" ? "offered" : "post_offered"))
        end
      end
      render :json => {:success => true, :msg => "Email delivery successfully."}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Email delivery failed."}
    end
  end

end
