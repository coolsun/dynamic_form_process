class PostOfferController < ApplicationController

  def invitation_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("Post Match")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = params[:procedureId].to_i
    location_list = []
    role_list = []
    if is_admin || is_hiring_mgr(procedure_id)
      logger.info "==get_mgr_rank_list = admin=="
      location_list = Location.where(:procedure_id => procedure_id).pluck(:id)
      role_list = Role.where(:procedure_id => procedure_id).pluck(:id)
    else
      logger.info "==get_mgr_rank_list = mgrs=="
      location_list = Location.where(:procedure_id => procedure_id, :id => current_user_location_mgr_location_ids).pluck(:id)
      role_list = Role.where(:procedure_id => procedure_id, :id => current_user_role_mgr_role_ids).pluck(:id)
    end
    filter_options = {
      :is_admin => is_admin,
      :locations => location_list,
      :roles => role_list,
    }
    post_offer_list, post_offers_total = Position.get_post_offer_invitation_list(rsas_table_params, filter_options)
    render :json => {:success => true, :now => params[:page], :total => post_offers_total, :show => post_offer_list, :permission_to_active => permission_to_active}
  end

  def post_offer_mail_template
    mail_template = EmailTemplate.where(:email_type => "post_match_invitation", :procedure_id => params[:current_process_id], :is_active => true).first
    if mail_template
      render :json => {:success => true, :mail_template => mail_template}
    else
      render :json => {:success => false}
    end
  end

  def send_invite_email
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_offered_email")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    begin
      position_id = params[:position_id]
      if params[:email_info][:recipients]
        input_emails = params[:email_info][:recipients].collect{|obj| obj[:email]}
        not_match_emails = input_emails - User.where(:year_id => params[:current_year_id],:email => input_emails).pluck(:email)
        render :json => {:success => false, :msg => "The email #{not_match_emails.first} can't be sent successfully since it doesn't exist in the database."} and return if not_match_emails.present?

        user_ids = User.where(:year_id => params[:current_year_id],:email => input_emails).pluck(:id)   #match user email
        recipients = []
        user_ids.each do |user_id|
          applicant = Application.includes(:user).where(:position_id => params[:position_id], :user_id => user_id).first
          unless applicant
            applicant = Application.create(:position_id => params[:position_id], :user_id => user_id, :user_rank => 999999, :mgr_rank => 999999, :offered => "wait")
          end
          recipients << applicant.user.email
        end
        procedure = Procedure.find_by_id(params[:current_process_id])
        position = Position.includes(:role, :location).where(:id => params[:position_id])
        bcc = Procedure.admin_and_hiring_mgr_emails(params[:current_process_id]) + (params[:email_info][:bcc] ? params[:email_info][:bcc].collect{|obj| obj["email"]} : [])
        cc = params[:email_info][:cc] ? params[:email_info][:cc].collect{|obj| obj["email"]} : []
        step = ProcedureSubStep.joins(:procedure_step).where(:identify_name => "post_offer_invitations", :procedure_steps => {:procedure_id => procedure.id}).first
        recipients.each do |recipient|
          user = User.find_by_email(recipient)
          subject = EmailTemplate.replace_keyworld(params[:email_info][:subject], procedure, position, step, user)
          content = EmailTemplate.replace_keyworld(params[:email_info][:content], procedure, position, step, user)
          StanfordMailer.send_shipped(recipient, subject, content, bcc, cc)
        end
      end
      render :json => {:success => true, :msg => "Email delivery success"}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Email delivery failed"}
    end
  end

end
