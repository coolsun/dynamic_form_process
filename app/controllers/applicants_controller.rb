class ApplicantsController < ApplicationController

  def create
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController create, params: #{params}");
    i_year_id = params[:current_year_id].to_i;
    i_procedure_id = params[:current_process_id].to_i;
    success = true;
    error_code = "xSYS99999";

    procedure = Procedure.find_by_id(i_procedure_id);

    permissions = {};

    if (procedure.present? && procedure.status)
      i_user_id = nil;
      remote_user = nil;
      user = nil;

      if Rails.env == 'development' && session[:user_id].present?
        i_user_id = session[:user_id].to_i;
        dev_user = User.find_by_id(i_user_id);
        remote_user = dev_user.sunet_id;
      else

        # this is low secure method
        if session[:user_id].present?
          i_user_id = session[:user_id].to_i;
          change_user = User.find_by_id(i_user_id);

          if (change_user.blank?)
            session[:user_id] = nil;
            remote_user = request.headers["REMOTE_USER"];
          else
            remote_user = change_user.sunet_id;
          end
        else
          remote_user = request.headers["REMOTE_USER"];
        end

        #####################################################################################

=begin  this is high secure method
        remote_user = request.headers["REMOTE_USER"]
=end

      end

      logger.info "====ApplicantsController==create======== request.headers[\"REMOTE_USER\"] = #{request.headers["REMOTE_USER"]} ==============";
      logger.info "====ApplicantsController==create======== now use REMOTE_USER = #{remote_user} ==============";

      if remote_user.present?
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController create, remote_user: #{remote_user}");

        user = User.where(:sunet_id => remote_user, :year_id => i_year_id).first;
        if (user.blank?)
          user = create_user(remote_user, i_year_id);
          i_user_id = user.id
          if (user.blank? || user.is_get_people_soft.blank?)
            success = false;
            error_code = 'xSYS00012';
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController create, fail, create user fail, error_code #{error_code}");
          end;
        else
          i_user_id = user.id;
          if (user.is_get_people_soft.blank?)
            success = applicant_get_people_soft(user);

            if (!success)
              error_code = 'xSYS00012';
              logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController create, fail, re-get people soft fail, user:#{user.to_json}, error_code #{error_code}");
            end
          end
        end
        begin
          Transcript.get_grades(user)
        rescue Exception => e
          logger.error "== get_transcripts error #{e.message} =="
        end
      else
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController create, fail, without remote_user");
        success = false;
      end

      if (success && user.present?)
        success = applicant_apply(user, i_procedure_id);
      else
        logger.info("# #{Time.now} IP:#{request.remote_ip},  action: ApplicantsController create, fails, without user_id.");
        success = false;
      end

      session[:user_id] = i_user_id

      permissions = get_header_permission();
    else
      logger.info("# #{Time.now} IP:#{request.remote_ip},  action: ApplicantsController create, fails, procedure is not yet start.");
      success = false;
      permissions[:no_status] = true;
    end

    render :json => {
      :success => success,
      :authorities => user,
      :permissions => permissions,
      :eCode => error_code
    } and return;
  end

  def applicant_apply(user, i_procedure_id)
    success = false;

    applied_applicant = Applicant.where(:user_id => user.id, :procedure_id => i_procedure_id);

    if (applied_applicant.blank?)
       applicant = Applicant.apply(user.id, i_procedure_id);

      if (applicant.blank? || applicant.id.blank?)
        logger.info("# #{Time.now} IP:#{request.remote_ip},  action: ApplicantsController applicant_apply fail.");
      else
        logger.info("# #{Time.now} IP:#{request.remote_ip},  action: ApplicantsController applicant_apply success, applicant: #{applicant.to_json}.");
        success = true;
      end
    else
      success = true;
    end

    return success;
  end

  def create_user(s_sunet_id, i_year_id)
    user = nil;
    if (Rails.env == "production")
      client = PeoplesoftDetail.get_people_soft(s_sunet_id);

      message = nil;
      begin
        message = client.get();
      rescue => e
        error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, at production create_user, sunet_id: #{s_sunet_id}, e.message : #{e.message}, e.backtrace : #{e.backtrace}"
        logger.error(error_msg)
        StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
      end

      if (message)
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create_user, stanford_SSL_saservice2_message #{message}");
        json_message = JSON.parse(message);
        httpStatusCode = json_message["httpStatusCode"];

        if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
          # error
          # 1. httpStatusCode = 401: not an authorized.
          # 2. {"errorMessage":"System can not find the target student identified by bsun2"}

          error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, at production create_user, parse message, sunet_id: #{s_sunet_id}"
          logger.error(error_msg)
          StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
        else
          begin
            new_user = nil;
            peoplesoft = User.parse_peoplesoft(json_message);

            first_name = peoplesoft.first_name;
            middle_name = peoplesoft.middle_name;
            last_name = peoplesoft.last_name;
            suid = peoplesoft.suid;
            email = peoplesoft.email;
            sunet_id = peoplesoft.sunet_id;
            gender = peoplesoft.gender;
            housingRemainYears = peoplesoft.housingRemainYears;
            academicStandings = peoplesoft.academicStandings;
            academics = peoplesoft.academics;
            addresses = peoplesoft.addresses;
            phones = peoplesoft.phones;

            new_user = User.create(
              :first_name => first_name,
              :middle_name => middle_name,
              :last_name => last_name,
              :suid => suid,
              :email => email,
              :sunet_id => sunet_id,
              :gender => gender,
              :is_admin => false,
              :year_id => i_year_id,
              :is_get_people_soft => false,
              :academic_year_remaining => housingRemainYears,
            );

            new_detail = nil;
            if (new_user.present?)
              new_detail = PeoplesoftDetail.create(
                :user_id => new_user.id,
                :academics => academics,
                :addresses => addresses,
                :phones => phones,
                :academic_standings => academicStandings
              )
            end

            if (new_detail.present?)
              new_user.is_get_people_soft = true;
              new_user.save();
            end

            user = new_user;
          rescue Exception => e
            error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create user, sunet_id:#{s_sunet_id}, e.message : #{e.message},   e.backtrace : #{e.backtrace}"
            logger.error(error_msg)
            StanfordMailer.send_admin("System Error", error_msg).deliver
          end
        end # if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
      end # if (message)

    elsif (STANFORD68)
      # sunetid: ewoodson
      client = PeoplesoftDetail.get_people_soft('ewoodson');

      message = nil;
      begin
        message = client.get();
      rescue => e
        error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, at STANFORD68 create_user, sunet_id: #{s_sunet_id}, e.message : #{e.message},   e.backtrace : #{e.backtrace}"
        logger.error(error_msg)
        StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
      end

      if (message)
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create_user, stanford_SSL_saservice2_message #{message}");
        json_message = JSON.parse(message);
        httpStatusCode = json_message["httpStatusCode"];

        if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
          # error
          # 1. httpStatusCode = 401: not an authorized.
          # 2. {"errorMessage":"System can not find the target student identified by bsun2"}

          error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, dev 6868 create_user, get_people_soft fail dev 6868"
          logger.error(error_msg)
          StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
        else
          begin
            new_user = nil;

            peoplesoft = User.parse_peoplesoft(json_message);

            first_name = peoplesoft.first_name;
            middle_name = peoplesoft.middle_name;
            last_name = peoplesoft.last_name;
            suid = peoplesoft.suid;
            email = peoplesoft.email;
            sunet_id = peoplesoft.sunet_id;
            gender = peoplesoft.gender;
            housingRemainYears = peoplesoft.housingRemainYears;
            academicStandings = peoplesoft.academicStandings;
            academics = peoplesoft.academics;
            addresses = peoplesoft.addresses;
            phones = peoplesoft.phones;

            new_user = User.create(
              :first_name => s_sunet_id,
              :middle_name => '',
              :last_name => '',
              :suid => "fake_suid_#{Time.now.to_i}",
              :email => "fake_e_#{Time.now.to_i}@fake.stanford.edu",
              :sunet_id => s_sunet_id,
              :gender => gender,
              :is_admin => false,
              :year_id => i_year_id,
              :is_get_people_soft => false,
              :academic_year_remaining => housingRemainYears,
            );

            new_detail = nil;
            if (new_user.present?)
              new_detail = PeoplesoftDetail.create(
                :user_id => new_user.id,
                :academics => academics,
                :addresses => addresses,
                :phones => phones,
                :academic_standings => academicStandings
              )
            end

            if (new_detail.present?)
              new_user.is_get_people_soft = true;
              new_user.save();
            end

            user = new_user;
          rescue Exception => e
            error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create user at if (message), sunet_id:#{s_sunet_id}, e.message : #{e.message}, e.backtrace : #{e.backtrace}"
            logger.error(error_msg)
            StanfordMailer.send_admin("System Error", error_msg).deliver
          end
        end # if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
      end # if (message)
    elsif (Rails.env == "development")
      new_user = nil;
      new_user = User.create(
        :first_name => "firstName#{Time.now.to_i}",
        :middle_name => "",
        :last_name => "lastName#{Time.now.to_i}",
        :email => "fake_peple_soft_#{Time.now.to_i}@fake.stanford.edu",
        :sunet_id => "fake_sunetId_#{Time.now.to_i}",
        :gender => "fake_gender_#{Time.now.to_i}",
        :is_admin => false,
        :year_id => i_year_id,
        :is_get_people_soft => false
      );


      if (new_user.present?)
        new_detail = nil;

        new_detail = PeoplesoftDetail.create(
          :user_id => new_user.id,
          :academics => "[{\"cumGPA\":\"3.544\",\"status\":\"AC\",\"academicPlanType\":\"IntDisHon\",\"academicPlan\":\"Ethics in Society (IHn)\",\"academicCareer\":\"UG\",\"admitTerm\":\"2011-2012 Autumn\",\"academicLevel\":\"Senior\"},{\"cumGPA\":\"3.544\",\"status\":\"AC\",\"academicPlanType\":\"Major\",\"academicPlan\":\"Science, Tech, \\u0026 Soc (BS)\",\"academicCareer\":\"UG\",\"admitTerm\":\"2011-2012 Autumn\",\"academicLevel\":\"Senior\"}]",
          :addresses => "[{\"address\":\"7 Old Mill Road, Westport, CT, USA, 06880\",\"type\":\"HOME\"}]",
          :phones => "[{\"phoneNumber\":\"203-246-3587\",\"type\":\"CELL\"}]",
          :academic_standings => "[]"
        )
      end

      if (new_detail.present?)
        new_user.is_get_people_soft = true;
        new_user.save();
      end
      user = new_user;
    end

    return user;
  end

  def applicant_get_people_soft(user)
    success = false;

    if (Rails.env == "production" || STANFORD68)
      s_sunet_id = (Rails.env == "production")? user.sunet_id : 'ewoodson';

      client = PeoplesoftDetail.get_people_soft(s_sunet_id);

      message = nil;
      begin
        message = client.get();
      rescue => e
        error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, sunet_id: #{s_sunet_id}, e.message : #{e.message}, e.backtrace : #{e.backtrace}"
        logger.error(error_msg)
        StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
      end

      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, stanford_SSL_saservice2_message #{message}");
      if (message)
        json_message = JSON.parse(message);
        httpStatusCode = json_message["httpStatusCode"];

        if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
          # error
          # 1. httpStatusCode = 401: not an authorized.
          # 2. {"errorMessage":"System can not find the target student identified by bsun2"}

          error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, at production, get_people_soft fail, sunet_id: #{s_sunet_id}"
          logger.error(error_msg)
          StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
        else
          begin
            peoplesoft = User.parse_peoplesoft(json_message);

            first_name = peoplesoft.first_name;
            middle_name = peoplesoft.middle_name;
            last_name = peoplesoft.last_name;
            suid = peoplesoft.suid;
            email = peoplesoft.email;
            sunet_id = peoplesoft.sunet_id;
            gender = peoplesoft.gender;
            housingRemainYears = peoplesoft.housingRemainYears;
            academicStandings = peoplesoft.academicStandings;
            academics = peoplesoft.academics;
            addresses = peoplesoft.addresses;
            phones = peoplesoft.phones;

            user.first_name = (Rails.env == "production")? first_name : user.first_name;
            user.middle_name = middle_name;
            user.last_name = last_name;
            user.suid = (Rails.env == "production")? suid : user.suid;
            user.email = (Rails.env == "production")? email : user.email;
            user.gender = gender;
            user.academic_year_remaining = housingRemainYears;

            peoplesoft_detail = PeoplesoftDetail.find_by_user_id(user.id);

            if (peoplesoft_detail.present?)
              peoplesoft_detail.academics = academics;
              peoplesoft_detail.addresses = addresses;
              peoplesoft_detail.phones = phones;
              peoplesoft_detail.academic_standings = academicStandings;
              peoplesoft_detail.save();
            else
              peoplesoft_detail = PeoplesoftDetail.create(
                :user_id => user.id,
                :academics => academics,
                :addresses => addresses,
                :phones => phones,
                :academic_standings => academicStandings
              );
            end

            if (peoplesoft_detail.present?)
              user.is_get_people_soft = true;
              user.save();
              success = true;
            end
          rescue Exception => e
            error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, sunet_id: #{s_sunet_id}, e.message : #{e.message},   e.backtrace : #{e.backtrace}"
            logger.error(error_msg)
            StanfordMailer.send_admin("System Error", error_msg).deliver
          end
        end # if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
      end # if (message)
    elsif (Rails.env == "development")
      peoplesoft_detail = PeoplesoftDetail.find_by_user_id(user.id);
      academics = "[{\"cumGPA\":\"3.544\",\"status\":\"AC\",\"academicPlanType\":\"IntDisHon\",\"academicPlan\":\"Ethics in Society (IHn)\",\"academicCareer\":\"UG\",\"admitTerm\":\"2011-2012 Autumn\",\"academicLevel\":\"Senior\"},{\"cumGPA\":\"3.544\",\"status\":\"AC\",\"academicPlanType\":\"Major\",\"academicPlan\":\"Science, Tech, \\u0026 Soc (BS)\",\"academicCareer\":\"UG\",\"admitTerm\":\"2011-2012 Autumn\",\"academicLevel\":\"Senior\"}]";
      addresses = "[{\"address\":\"7 Old Mill Road, Westport, CT, USA, 06880\",\"type\":\"HOME\"}]";
      phones = "[{\"phoneNumber\":\"203-246-3587\",\"type\":\"CELL\"}]";
      academicStandings = "[]";

      if (peoplesoft_detail.present?)
        peoplesoft_detail.academics = academics;
        peoplesoft_detail.addresses = addresses;
        peoplesoft_detail.phones = phones;
        peoplesoft_detail.academic_standings = academicStandings;
        peoplesoft_detail.save();
      else
      peoplesoft_detail = PeoplesoftDetail.create(
        :user_id => user.id,
        :academics => academics,
        :addresses => addresses,
        :phones => phones,
        :academic_standings => academicStandings
      )
      end

      if (peoplesoft_detail.present?)
        user.is_get_people_soft = true;
        user.save();
        success = true;
      end
    end

    return success;
  end

  def applicant_list
    procedure_id = rsas_table_params.i_procedure_id

    permissions = check_user_permissions(["lower_mgr_see_time", "see_applicant_filled_forms", "applicant_disqualify", "force_submit"])
    all_limits = LimitPeriod.where(:procedure_id => procedure_id).order(:t_start => :asc)
                            .as_json(:methods => [:t_start_string, :roles, :locations, :t_end_string],
                                     :only => [:id, :t_start_string, :roles, :locations, :t_end_string])
    show_applicant_list = check_user_permission("time_to_see_applicant_forms")[0]
    if !show_applicant_list
      render :json => {:permissions => permissions, :all_limits => all_limits} and return
    end

    status_list = ['All', 'Submitted', 'Offered', 'Un-offered', 'Accepted', 'Unaccepted']

    position_ids, location_ids, role_ids, permission = user_can_see_position_location_role_ids(procedure_id)

    if params[:sub_step] == "manage_available_applicants"
      position_ids = Position.where(:procedure_id => procedure_id).pluck(:id)
      location_ids = Location.where(:procedure_id => procedure_id).pluck(:id)
      role_ids     = Role.where(:procedure_id => procedure_id).pluck(:id)
    end

    filter_interviews = {}
    if permission != 'LM'
      status_list = status_list.insert(2, 'Not submitted')
      status_list = status_list.insert(-1, 'Disqualify')
      filter_interviews[:round_id] = Round.where(:procedure_id => procedure_id).pluck(:id)
    else
      filter_interviews[:id] = PositionsInInterview.where(:position_id => position_ids).pluck(:interview_id)
    end
    interview_list = []
    Interview.includes(:round).where(filter_interviews).each do |interview|
      interview_list << {
        :id => interview.id,
        :title => interview.round.title + ": " + interview.name
      }
    end

    locations  = params[:locations].kind_of?(Array)  && params[:locations].present?  ? params[:locations]  : location_ids
    roles      = params[:roles].kind_of?(Array)      && params[:roles].present?      ? params[:roles]      : role_ids
    interviews = params[:interviews].kind_of?(Array) && params[:interviews].present? ? params[:interviews] : []

    location_list = Location.select(:id, :name).where(:id => location_ids).as_json
    role_list = Role.select(:id, :name).where(:id => role_ids).as_json

    if params[:sub_step] == "manage_available_applicants"
      status_list = ['Un-offered']
      params[:status] = 'Un-offered'
    end
    status = params[:status] || 'All'  # 'All', 'Submitted', 'Not submitted', 'Offered', 'Accepted', 'Unaccepted'
    filter_options = {
      :permission => permission,
      :permission_positions => position_ids,
      :locations => locations,
      :roles => roles,
      :interviews => interviews,
      :status => status,
      :question_filters => params[:question_filters].blank? ? [] : params[:question_filters],
    }

    logger.warn "== permission        #{permission} =="
    logger.warn "== role_list         #{role_list} =="
    logger.warn "== location_list     #{location_list}  =="
    logger.warn "== roles             #{roles} =="
    logger.warn "== locations         #{locations} =="
    logger.warn "== position_ids      #{position_ids} =="
    logger.info "== question_filters  #{filter_options[:question_filters]}=="

    display_rd_flag_button = check_user_permission("rd_flag_button")[0]
    applicant_list, applicants_total, forms_and_questions = Applicant.get_applicant_list(rsas_table_params, filter_options, current_user.status, display_rd_flag_button)
    #logger.info "== applicant_list #{applicant_list} =="

    render :json => {
      :now => params[:page],
      :total => applicants_total,
      :show => applicant_list,
      :status_list => status_list,
      :location_list => location_list,
      :role_list => role_list,
      :interview_list => interview_list.sort! { |a, b| a[:title].downcase <=> b[:title].downcase },
      :permissions => permissions,
      :all_limits => all_limits,
      :forms_and_questions => forms_and_questions
    }
  end

  def submit_application
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Submit Application")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id]
    applicant = Applicant.where({:user_id => session[:user_id], :procedure_id => procedure_id}).first
    if applicant
      if applicant.try("application_submit_at")
        applicant.application_submit_at = nil
        email_type = "withdraw_application"
        Invite.remove_applicant_procedure_invites(applicant.user_id, procedure_id);
        Interviewee.remove_applicant_procedure_interviewees(applicant.user_id, procedure_id);
      else
        applicant.application_submit_at = Time.now
        email_type = "submission_application"
      end
      applicant.save
      applicant.update_peoplesoft_and_transcripts

      begin
        procedure = Procedure.find_by_id(procedure_id)
        position_ids = Application.where(:user_id => applicant.user_id).pluck(:position_id)
        positions = Position.includes(:role, :location).where(:id => position_ids, :procedure_id => procedure.id)
        user = applicant.user
        bcc = Procedure.admin_and_hiring_mgr_emails(procedure_id)
        mail_templates = EmailTemplate.where(:email_type => email_type, :procedure_id => procedure_id, :is_active => true)
        mail_templates.each do |mail_template|
          new_title = EmailTemplate.replace_keyworld(mail_template.title, procedure, positions, nil, user)
          new_content = EmailTemplate.replace_keyworld(mail_template.content, procedure, positions, nil, user)
          StanfordMailer.send_shipped(applicant.user.email, new_title, new_content, bcc)
        end
        render :json => {:success => true, :msg => "The application has been " + (email_type == "withdraw_application" ? "withdrawn" : "submitted") + " successfully."}
      rescue Exception => e
        logger.info "== send submit_application mail error #{e.message} =="
        render :json => {:success => false, :msg => "Email delivery failed."}
      end
    else
      render :json => {:success => false, :msg => "Failed to " + (email_type == "withdraw_application" ? "withdraw" : "submit") + " the application."}
    end
  end

  def send_email_to_applicants
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_email_to_applicants")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    begin
      bcc = Procedure.admin_and_hiring_mgr_emails(params[:current_process_id]) + (params[:email_info][:bcc] ? params[:email_info][:bcc].collect{|obj| obj["email"]} : [])
      cc = params[:email_info][:cc] ? params[:email_info][:cc].collect{|obj| obj["email"]} : []
      StanfordMailer.send_shipped(params[:email_info][:recipients].collect{|obj| obj["email"]}, params[:email_info][:subject], params[:email_info][:content], bcc, cc)
      render :json => {:success => true, :msg => "Email delivery success"}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Email delivery failure"}
    end
  end

  def applicant_disqualify
    permission_to_show, permission_to_active, permission_message = check_user_permission("applicant_disqualify")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    disqualify_applicant_data = Applicant.where(:user_id => params[:user_id], :procedure_id => params[:current_process_id]).first

    disqualify_applicant_data.disqualify = !disqualify_applicant_data.disqualify
    disqualify_applicant_data.save!

    msg = disqualify_applicant_data.disqualify ? "The applicant has been disqualified successfully." : "You have canceled the disqualification."

    render :json => {:success => true, :msg => msg, :disqualify => disqualify_applicant_data.disqualify }
  end

  def get_user_authority
    show_sunet_id();

    session_user_id = session[:user_id];
    params_user_id = params[:user_id];
    request_headers_remote_user = request.headers["REMOTE_USER"];

    user = User.get_and_check_user_authority(session_user_id, params_user_id, request_headers_remote_user, is_admin());

    if user
      session[:user_id] = user.id
      permissions = get_header_permission();

      render :json => {
        :success => true,
        :authorities => user,
        :permissions => permissions
      }
    else
      logger.info "== login failed =="
      render :json => {:success => false}
    end
  end

  def force_submit
    permission_to_show, permission_to_active, permission_message = check_user_permission("force_submit")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    begin
      applicant = Applicant.where(:user_id => params[:user_id], :procedure_id => params[:current_process_id]).first
      if applicant
        applicant.application_submit_at = Time.now();
        applicant.save!
      end
      render :json => {:success => true, :msg => "This application has been submitted successfully."}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Failed to submit this application. Please try again."}
    end
  end

  def download_answer_xls_file
    procedure_id = params[:current_process_id]

    position_ids = Position.where(:procedure_id => procedure_id).pluck(:id)
    location_ids = Location.where(:procedure_id => procedure_id).pluck(:id)
    role_ids     = Role.where(:procedure_id => procedure_id).pluck(:id)

    locations  = params[:locations].present?  ? JSON.parse(params[:locations]).collect {|obj| obj["id"]}  : location_ids
    roles      = params[:roles].present?      ? JSON.parse(params[:roles]).collect {|obj| obj["id"]}      : role_ids
    interviews = params[:interviews].present? ? JSON.parse(params[:interviews]).collect {|obj| obj["id"]} : []

    params[:status] = 'Un-offered'  if params[:sub_step] == "manage_available_applicants"
    status = params[:status] || 'All'  # 'All', 'Submitted', 'Not submitted', 'Offered', 'Accepted', 'Unaccepted'

    position_ids, location_ids, role_ids, permission = user_can_see_position_location_role_ids(procedure_id)

    filter_options = {
      :locations => locations,
      :roles => roles,
      :interviews => interviews,
      :status => status,
      :question_filters => params[:form_question_filters].blank? ? [] : JSON.parse(params[:form_question_filters]),
    }

    search_fields = ['users.first_name', 'users.middle_name', 'users.last_name', 'users.email', 'users.suid', 'users.sunet_id']
    search_condition = RsasTools.get_where_search_condition(search_fields, params[:searchText])

    filter_where_condition, filter_where_not_condition = Applicant.applicant_list_setting_where_condition(filter_options, procedure_id)

    if filter_options[:question_filters].present?
      question_filters_user_ids = FormInput.question_filters_user_ids(filter_options[:question_filters], procedure_id)
      logger.info "== question_filters_user_ids #{question_filters_user_ids} =="
      if question_filters_user_ids.blank?
        filter_match_question_applicants = "applicants.user_id = 0"
      else
        query = []
        question_filters_user_ids = question_filters_user_ids.in_groups_of(1000, false)
        question_filters_user_ids.each do |question_filters_user_ids_of_1000|
          #logger.info "== question_filters_user_ids_of_1000 #{question_filters_user_ids_of_1000} =="
          query << "applicants.user_id in (#{question_filters_user_ids_of_1000.join(',')})"
        end
        filter_match_question_applicants = query.join(' or ')
      end
    else
      filter_match_question_applicants = ""
    end

    applicants = Applicant.includes(:user => [{:applications => {:position => [:location, :role]}}, {:invitees => :interview}])
                  .where(:procedure_id => procedure_id)
                  .where(filter_where_condition)
                  .where.not(filter_where_not_condition)
                  .where(filter_match_question_applicants)
                  .where(search_condition)

    format_form_type = {
      "System Forms" => "System",
      "Attachable Forms" => "Application",
      "Recommendations" => "Recommender"
    }

    user_ids = applicants.pluck(:user_id).uniq
    logger.info "== user_ids #{user_ids} =="

    questions = []
    query_details = filter_options[:question_filters]
    query_details.each do |query_detail|
      questions << query_detail["question"]
      logger.info " == query_detail['question'] #{query_detail['question'].as_json} =="
    end

    @titles = ["Name", "SUNet Id", "SUID", "Status", "Interview(selected)", "Location", "Role"] + questions
    @data_types = [nil, nil , :string, nil]
    @user_record = []

    applicants = Applicant.includes(:user).where(:user_id => user_ids, :procedure_id => procedure_id)
    applicants.each do |applicant|
      user_data = applicant.user
      answers = []
      query_details.each do |query_detail|
        form_id = Form.where(:procedure_id => procedure_id ,:form_type => format_form_type[query_detail["form_type"]], :form_name => query_detail["form_name"]).first.id
        if query_detail["form_type"] != "Recommendations"
          user_fill_form_id = UserForm.where(:form_id => form_id, :user_id => applicant.user_id).first.try(:id)
        else
          user_fill_form_id = RecommendationForm.includes(:recommendation_record).where(:recommendation_records => {:recommendation_form_id => form_id, :user_id => applicant.user_id}).first.try(:id)
        end
        next if !user_fill_form_id
        question = query_detail['question'].gsub("'", "''")  #oracle escape special characters
        query_value = FormInput.where(:form_id => user_fill_form_id, :form_table => (query_detail["form_type"] == 'Recommendations' ? 'RECOMMENDATION_FORMS' : 'USER_FORMS'))
                               .where("to_char(form_inputs.schema_description) = '#{question}'").pluck(:schema_value).first
        answers << query_value
      end

      if (['admin', 'RM'].include?(permission))
        round_titles = Round.joins(:interviews => :invites).where(:procedure_id => procedure_id, :invites => {:invitee_user_id => applicant.user_id}).pluck(:title).join(", ")
      else
        round_titles = ""
      end
      applicant_poitions = []
      if permission == 'admin'
        applicant_select_poitions  = Position.includes(:applications).where(:procedure_id => procedure_id, :applications => {:user_id => applicant.user_id})
        if applicant_select_poitions.present?
          applicant_select_locations = Location.where(:id => applicant_select_poitions.pluck(:location_id)).pluck(:name).join(", ")
          applicant_select_roles     = Role.where(:id => applicant_select_poitions.pluck(:role_id)).pluck(:name).join(", ")
        else
          applicant_select_locations = applicant_select_roles = ""
        end
      elsif ['LM', 'RMLM'].include?(permission)
        applicant_select_poitions = Position.includes(:applications).where(:applications => {:user_id => applicant.user_id, :position_id => position_ids})
        if applicant_select_poitions.present?
          applicant_select_locations = Location.where(:id => applicant_select_poitions.pluck(:location_id)).pluck(:name).join(", ")
          applicant_select_roles     = Role.where(:id => applicant_select_poitions.pluck(:role_id)).pluck(:name).join(", ")
        else
          applicant_select_locations = applicant_select_roles = ""
        end
      else
        applicant_poitions = ["Only admin or LM can see that."]
      end
      @user_record << [user_data.name, user_data.sunet_id, user_data.suid, applicant.status, round_titles, applicant_select_locations, applicant_select_roles] + answers
    end

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='applicants study abroad this year.xlsx'"
      }
    end
  end

  private

    def user_can_see_position_location_role_ids(procedure_id)
      if is_admin || is_hiring_mgr(procedure_id)
        position_ids = Position.where(:procedure_id => procedure_id).pluck(:id)
        location_ids = Location.where(:procedure_id => procedure_id).pluck(:id)
        role_ids     = Role.where(:procedure_id => procedure_id).pluck(:id)
        permission = 'admin'
      else
        location_ids = Location.where(:procedure_id => procedure_id, :id => current_user_location_mgr_location_ids).pluck(:id)
        role_ids = Role.where(:procedure_id => procedure_id, :id => current_user_role_mgr_role_ids).pluck(:id)
        if location_ids.blank? && role_ids.present?
          position_ids = Position.where(:role_id => role_ids).pluck(:id)
          location_ids = Position.where(:role_id => role_ids).pluck(:location_id)
          permission = 'RM'
        elsif role_ids.blank? && location_ids.present?
          position_ids = Position.where(:location_id => location_ids).pluck(:id)
          role_ids = Position.where(:location_id => location_ids).pluck(:role_id)
          permission = 'LM'
        else
          positions = Position.where("role_id in (?) OR location_id in (?)", role_ids, location_ids)
          position_ids = positions.pluck(:id)
          location_ids = positions.pluck(:location_id)
          role_ids     = positions.pluck(:role_id)
          permission = 'RMLM'
        end
      end
      return position_ids, location_ids, role_ids, permission
    end

end
