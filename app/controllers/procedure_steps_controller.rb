class ProcedureStepsController < ApplicationController

  def update
    @procedure_step = ProcedureStep.find_by_id(params[:id])

    if @procedure_step.id && @procedure_step.update(update_procedure_step_params)
      render :json => {"success" => true}
    else
      render :json => {"success" => false, "message" => @procedure_step.errors}
    end
  end

  def show_manager_procedure_steps
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process Step Sort And Display")
    render :json => {:success => false, :msg => permission_message, :permission_to_show => permission_to_show} and return if !permission_to_show
    show_process = permission_to_show

    procedure_id = params[:current_process_id]
    i_user_id = session[:user_id];

    procedure_steps = ProcedureStep.get_procedure_steps_list({:procedure_id => procedure_id})

    b_admin = is_admin();
    b_hiring_mgr = is_hiring_mgr(procedure_id);

    if procedure_steps
      procedure_steps.each do |procedure_step|
        permission_to_show, permission_to_active, permission_message = check_user_permission(procedure_step["name"])
        procedure_step["permission"] = {
          "show" => permission_to_show,
          "active" => permission_to_active
        }

        procedure_step["procedure_sub_steps"].each do |sub_step|
          sub_step["go_sub_step"] = true;
          b_round_related = false;
          if procedure_step["name"] == "Interview" || (procedure_step["name"] == "Post Match" && sub_step["name"] == 'Post Match Interview')
            permission_to_show, permission_to_active, permission_message = check_user_permission("interview")

            i_round_id = (sub_step["identify_name"].gsub('interview', '')).to_i;
            if (i_round_id)
              if (sub_step["name"] != 'Post Match Interview')
                b_round_permission = Round.check_round_permission_by_id(i_user_id, i_round_id, b_admin, b_hiring_mgr);

                if (b_round_permission)
                  b_round_related = Round.is_related_interviewer(i_round_id, i_user_id);
                else
                  permission_to_show = false;
                  permission_to_active = false;
                  sub_step["go_sub_step"] = false;
                end
              else
                b_round_related = Round.is_related_interviewer(i_round_id, i_user_id);
              end
            else
              permission_to_show = false;
              permission_to_active = false;
            end
          else
            permission_to_show, permission_to_active, permission_message = check_user_permission(sub_step["identify_name"], {:substep_check => sub_step["id"]})
          end

          sub_step["permission"] = {
            "show" => permission_to_show,
            "active" => permission_to_active,
            "round_related" => b_round_related
          }
        end
      end

      permission_to_show, permission_to_active, permission_message = check_user_permission("Process Step Sort And Display")
      render :json => {:success => true, :procedure_steps => procedure_steps, :sort_and_display => permission_to_active, :permission_to_show => show_process}
    else
      render :json => {:success => false, :msg => "Failed to get the process steps."}
    end
  end


  def show_applicant_procedure_steps
    procedure_id = params[:current_process_id]
    i_user_id = session[:user_id]

    procedure_steps = ProcedureStep.get_procedure_steps_list({:procedure_id => procedure_id})

    if procedure_steps
      procedure_steps.each do |procedure_step|
        permission_to_show, permission_to_active, permission_message = check_user_permission(procedure_step["name"])
        procedure_step["permission"] = {
          "show" => permission_to_show,
          "active" => permission_to_active
        }

        procedure_step["procedure_sub_steps"].each do |sub_step|
          if procedure_step["name"] == "Interview" || (procedure_step["name"] == "Post Match" && sub_step["name"] == 'Post Match Interview')
            permission_to_show, permission_to_active, permission_message = check_user_permission("interview")

            i_round_id = (sub_step["identify_name"].gsub('interview', '')).to_i;
            round_related = Round.is_related_applicant(i_round_id, i_user_id);
          else
            permission_to_show, permission_to_active, permission_message = check_user_permission(sub_step["identify_name"])
          end
          sub_step["permission"] = {
            "show" => permission_to_show,
            "active" => permission_to_active,
            "round_related" => round_related
          }
        end
      end

      if ApplyWhiteList.where(:procedure_id => procedure_id, :user_id => i_user_id).first
        apply_white_list = true
      else
        apply_white_list = false
      end

      permission_to_show, permission_to_active, permission_message = check_user_permission("Process Step Sort And Display")
      render :json => {:success => true, :procedure_steps => procedure_steps, :sort_and_display => permission_to_active, :apply_white_list => apply_white_list}
    else
      render :json => {:success => false, :message => procedure_step.errors}
    end
  end

  def applicant_status
    user_id = session[:user_id]
    procedure_id = params[:current_process_id]
    main_step = ProcedureStep.where({:procedure_id => procedure_id, :name => "Application"})
    status = {}
    if main_step.length > 0
      main_step_id = main_step.first.id
      procedure_sub_steps = ProcedureSubStep.where({:procedure_step_id => main_step_id})
      can_submit_applicantion = true
      procedure_sub_steps.each do |procedure_sub_step|
        if procedure_sub_step.identify_name == "select_position"
          positions = Application.includes(:position).where({:user_id => user_id, :positions => {:procedure_id => procedure_id}})
          logger.info "== positions #{positions.length} =="
          if positions.length > 0
            status[procedure_sub_step.identify_name] = true
          else
            status[procedure_sub_step.identify_name] = false
          end
        elsif procedure_sub_step.identify_name == "fill_in_form"
          filled_count = 0
          status[procedure_sub_step.identify_name] = true
          system_forms = Form.where({:procedure_id => procedure_id, :display => true, :form_type => "System"}).order("rank")
          forms = system_forms + Form.get_attachable_forms(procedure_id, user_id)
          forms.each do |form|
            user_form = UserForm.where("user_id = ? and procedure_id = ? and form_id = ? and submit_date is not null", user_id, procedure_id, form.id).first
            if !user_form && status[procedure_sub_step.identify_name] = true
              status[procedure_sub_step.identify_name] = false
            else
              filled_count += 1
            end
          end
          status["form_progress"] = filled_count.to_s + " / " + forms.length.to_s
        elsif procedure_sub_step.identify_name == "recommendation"
          application_step = ProcedureStep.where(:name => "Application", :procedure_id => procedure_id).first
          if !(ProcedureSubStep.where(:identify_name => "recommendation", :procedure_step_id => application_step.id).first.enabled)
            status[procedure_sub_step.identify_name] = true
          else
            records = RecommendationRecord.where(:user_id => user_id, :procedure_id => procedure_id)
            logger.info "== RecommendationRecord #{records.length} =="
            r_number = RecommendationSetting.find_by_procedure_id(procedure_id)

            logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            #ST958 if only select one position, check this position whether offered last year or not. If true, no need recommendation.
            check_no_need_recommendation = r_number.no_need_recommendation
            logger.info("check_no_need_recommendation: #{check_no_need_recommendation}")
            check_last_offer = false
            positions = Application.includes(:position).where({:user_id => user_id, :positions => {:procedure_id => procedure_id}})
            logger.info("positions: #{positions.to_json}")

            if check_no_need_recommendation && positions.length == 1
              year_id = params[:current_year_id]
              this_year_name = Year.find(year_id).name
              last_year = Year.where(next_year: this_year_name).first
              sunet_id = User.find(user_id).sunet_id
              logger.info("this_year_name: #{this_year_name}")
              logger.info("last_year: #{last_year}")
              logger.info("sunet_id: #{sunet_id}")

              if sunet_id.present? && last_year.present?
                user_last_year_id = User.where(sunet_id: sunet_id, year_id: last_year.id).first.id
                logger.info("user_last_year_id: #{user_last_year_id}")
                if user_last_year_id.present?
                  last_year_offerd_position = Position.includes(:applications).where(applications: {user_id: user_last_year_id, offer_accept: "accepted"}).first
                  logger.info("last_year_offerd_position: #{last_year_offerd_position.to_json}")
                  if last_year_offerd_position.present?
                    last_year_offerd_position_name = last_year_offerd_position.name
                    this_year_selected_position = Position.includes(:applications).where(procedure_id: procedure_id, name: last_year_offerd_position_name, applications: {user_id: user_id})
                    check_last_offer = true if this_year_selected_position.present?
                    logger.info("last_year_offerd_position_name: #{last_year_offerd_position_name}")
                    logger.info("this_year_selected_position: #{this_year_selected_position}")
                    logger.info("check_last_offer: #{check_last_offer}")
                  end
                end
              end
            end
            logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

            if r_number && (records.length >= r_number.number || check_last_offer)
              status[procedure_sub_step.identify_name] = true
            else
              status[procedure_sub_step.identify_name] = false
            end
            status["recommendation_progress"] = records.length.to_s + " / " + r_number.number.to_s
          end
        elsif procedure_sub_step.identify_name == "submit_application"
          status[procedure_sub_step.identify_name] =  Applicant.is_application_sumbit(user_id, procedure_id)
          status["can_submit"] = can_submit_applicantion || status[procedure_sub_step.identify_name]
        end
        can_submit_applicantion = can_submit_applicantion & status[procedure_sub_step.identify_name]
      end
    end
    logger.info "== status #{status.to_json} =="
    if status
      render :json => {:success => true, :status => status}
    else
      render :json => {:success => false}
    end
  end

  def get_step_landing
    procedure_landing = ProcedureLanding.where(:procedure_id => params[:current_process_id], :step_name => params[:step_name]).first
    if procedure_landing
      render :json => {
        :success => true,
        :landing => procedure_landing.landing,
        :landing_after => change_landing_time_string(params[:current_process_id], procedure_landing.landing, params[:current_year_id])}
    else
      render :json => {:success => false, :msg => "There was a problem to get the landing page."}
    end
  end

  def update_step_landing
    procedure_landing = ProcedureLanding.where(:procedure_id => params[:current_process_id], :step_name => params[:step_name]).first
    procedure_landing.landing = params[:landing]
    procedure_landing.save

    render :json => {
      :success => true,
      :msg => "The landing page has been updated successfully.",
      :landing => procedure_landing.landing,
      :landing_after => change_landing_time_string(params[:current_process_id], procedure_landing.landing, params[:current_year_id])}
  end

  def change_landing_time_string(procedure_id, landing_content, year_id)
    landing_replace_word = landing_content
    time_hash = {}
    submit_end_time = nil
    recommendation_end_time = nil
    # ..
    process_step_times = ProcedureStep.where(:procedure_id => procedure_id).select(:id, :name, :t_start, :t_end)
    process_step_times.each do |process_step_time|
      step_name_no_space = process_step_time.name.gsub(" ","")
      landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}StartTime]]", process_step_time.t_start_string_for_landing)
      landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}EndTime]]", process_step_time.t_end_string_for_landing)
      process_sub_step_times = ProcedureSubStep.where(:procedure_step_id => process_step_time.id).select(:name, :t_start, :t_end)
      process_sub_step_times.each do |process_sub_step_time|
        sub_step_name_no_space = process_sub_step_time.name.gsub(" ","")
        landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}-#{sub_step_name_no_space}-StartTime]]", process_sub_step_time.t_start_string_for_landing)
        landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}-#{sub_step_name_no_space}-EndTime]]", process_sub_step_time.t_end_string_for_landing)
        if process_step_time.name == "Application" && process_sub_step_time.name == "Submit Application"
          submit_end_time = process_sub_step_time.t_end
        end
        if process_step_time.name == "Application" && process_sub_step_time.name == "Recommendation"
          recommendation_end_time = process_sub_step_time.t_end
        end
      end
    end
    # ..
    round_times = Round.where(:procedure_id => procedure_id).select(:title, :t_start, :t_end) # If just need interview not post match, add where condition :erasable => true
    round_times.each do |round_time|
      round_title_no_space = round_time.title.gsub(" ","")
      landing_replace_word = landing_replace_word.gsub("[[Round-#{round_title_no_space}-StartTime]]", round_time.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %I:%M %p"))
      landing_replace_word = landing_replace_word.gsub("[[Round-#{round_title_no_space}-EndTime]]",round_time.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %I:%M %p"))
    end
    # ..
    current_year = Year.where(:id => year_id).select(:name, :next_year).first
    current_process_data = Procedure.where(:id => procedure_id).select(:name, :contact_email).first
    landing_replace_word = landing_replace_word.gsub("[[CurrentYear]]", current_year.name.to_s)
    landing_replace_word = landing_replace_word.gsub("[[NextYear]]", current_year.next_year.to_s)
    landing_replace_word = landing_replace_word.gsub("[[CurrentProcess]]", current_process_data.name)
    landing_replace_word = landing_replace_word.gsub("[[ContactEmail]]", (current_process_data.contact_email ? current_process_data.contact_email : ""))
    # ..
    application_submit_at = Applicant.where(:user_id => current_user.id, :procedure_id => procedure_id).pluck(:application_submit_at).first
    if !application_submit_at.nil?
      submitted_message = "Your application materials were officially submitted for review on #{application_submit_at.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %I:%M %p")}"
    elsif application_submit_at.nil? && Time.now > submit_end_time
      submitted_message = "The due date has passed. Application materials are no longer being accepted. According to our records, you did NOT officially submit your application materials for review."
    else
      submitted_message = ""
    end
    landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutSubmitApplication]]", submitted_message)
    # ..
    recommendation_record_ids = RecommendationRecord.where(:user_id => current_user.id, :procedure_id => procedure_id, :disabled => false).pluck(:id)
    recommendation_form_length = RecommendationForm.where(:recommendation_record_id => recommendation_record_ids).length
    landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationRequested]]", recommendation_record_ids == 0 ?  "No recommendations have been requested." : "")
    landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationReceived]]", "#{recommendation_form_length} recommendations have been received.")
    landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationTimesUp]]", Time.now > recommendation_end_time ? "<b>The due date has passed.</b> Recommendations are no longer being accepted." : "")

    return landing_replace_word
  end

  private

  def update_procedure_step_params
    params.require(:procedure_step).permit(:rank, :t_start, :t_end, :enabled)
  end

end
