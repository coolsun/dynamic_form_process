class InterviewsController < ApplicationController
  include RsasTools
  before_action :set_interview, only: [:update, :destroy]


####################################################################################################
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_create")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active


    success = true;
    error_code = 'xSYS00000';
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController create, params: #{params}");


    i_round_id = params[:roundId].to_i;
    us_name = params[:name];
    us_place = params[:place];
    us_schedule_due_time = params[:scheduleDueTime];
    i_vacancy = params[:vacancy].to_i;
    b_interviewer_can_edit = params[:interviewerCanEdit];
    b_interviewer_can_schedule = params[:interviewerCanSchedule];
    i_interviewer_vacancy = params[:interviewerVacancy].to_i;
    i_max_time_slot_per_interviewer = params[:maxTimeSlotPerInterviewer].to_i;
    b_one_time_slot_per_applicant = params[:oneTimeSlotPerApplicant];
    us_time_list = params[:timeList];  # not use now:20140925
    us_positions = params[:positionIds];
    time_list = [];
    i_position_ids = [];


    round = Round.find_by_id(i_round_id);

    if (round)
      t_schedule_due_time = us_schedule_due_time.pst_t

      interview = Interview.new_interview(
        i_round_id,
        i_vacancy,
        us_name,
        t_schedule_due_time,
        b_one_time_slot_per_applicant,
        b_interviewer_can_edit,
        b_interviewer_can_schedule,
        i_interviewer_vacancy,
        i_max_time_slot_per_interviewer
      );


      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController create, interview: #{interview.to_json}");

      i_time_slot_ids = [];
      error_time_list = [];
      if (!interview[:id].is_a?(Integer))
        error_code = 'xDBI00001';
        logger.info("# #{Time.now} IP:#{request.remote_ip},  action: InterviewsController create, interview create fail, error_code: #{error_code}");
        success = false;
      else
        if (us_time_list.kind_of?(Array))
          us_time_list.each do |time|
            time_parse_start = Time.parse(time[:start]);
            time_parse_end = Time.parse(time[:end]);
            t_start = Time.utc(time_parse_start.year, time_parse_start.month, time_parse_start.day, time_parse_start.hour, time_parse_start.min);
            t_end = Time.utc(time_parse_end.year, time_parse_end.month, time_parse_end.day, time_parse_end.hour, time_parse_end.min);

            time_list << {
              :start => t_start,
              :end => t_end
            };
          end
        end

        if (us_positions.kind_of?(Array) && 0 < us_positions.length)
          i_position_ids = RsasTools.arr_attr_to_int(us_positions);
        end

        logger.info("time_list #{time_list}");
        time_list.each do |time|
          time_slot = TimeSlot.new_time_slot(interview[:id], us_place, time[:start], time[:end]);
          logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController create, time_slot #{time_slot.to_json}");
          if (time_slot)
            i_time_slot_ids << time_slot[:id];
          else
            error_code = 'xDBI00006';
            logger.info("# #{Time.now} IP:#{request.remote_ip},  action: InterviewsController create, time_slot create fail, error_code: #{error_code}");
            error_time_list << time;
            success = false;
          end
        end

        logger.info("i_interview_ids : #{i_time_slot_ids}");
        logger.info("error_time_list : #{error_time_list}")


        # this need write log.
        PositionsInInterview.multiple_create(interview[:id], i_position_ids);
      end
    else
      error_code = 'xSYS00002';
      logger.info("# #{Time.now} IP:#{request.remote_ip},  action: InterviewsController create, can't find this round, id:#{i_round_id}, error_code: #{error_code}");
      success = false;

    end


    render :json => {
      :success => success,
      :eCode => error_code
    };
  end # def create

####################################################################################################
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_setting")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    success = true;
    error_code = 'xSYS00000';
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, params: #{params}");


    i_interview_id = params[:id].to_i;
    i_vacancy = params[:vacancy].to_i;
    us_name = params[:name];
    b_interviewer_can_edit = params[:interviewerCanEdit];
    b_interviewer_can_schedule = params[:interviewerCanSchedule];
    i_interviewer_vacancy = params[:interviewerVacancy].to_i;
    i_max_time_slot_per_interviewer = params[:maxTimeSlotPerInterviewer].to_i;
    b_one_time_slot_per_applicant = params[:oneTimeSlotPerApplicant];
    us_time_list = params[:timeList];
    us_positions = params[:positionIds];
    us_schedule_due_time = params[:scheduleDueTime];

    t_schedule_due_time = us_schedule_due_time.pst_t

    update_data = {
      :vacancy => i_vacancy,
      :one_time_slot_per_applicant => b_one_time_slot_per_applicant,
      :interviewer_can_edit => b_interviewer_can_edit,
      :interviewer_can_schedule => b_interviewer_can_schedule,
      :interviewer_vacancy => i_interviewer_vacancy,
      :max_time_slot_per_interviewer => i_max_time_slot_per_interviewer,
      :name => us_name,
      :schedule_due_time => t_schedule_due_time
    };

    if (@interview.update(update_data))
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, interview:#{params[:id]} update success");
    else
      error_code = 'xDBU00001';
      success = false;
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, interview:#{params[:id]} update fail, error_code: #{error_code}");
    end

    render :json => {
      :success => success,
      :eCode => error_code
    };
  end # def update


####################################################################################################
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_delete")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    error_code = 'xSYS00000';
    success = true;

    if (@interview)
      time_slots = TimeSlot.where(:interview_id => @interview[:id])
      if (0 < time_slots.length)
        success = false;
        error_code = 'xDBD00005';
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController destroy, interview:#{params[:id]} delete fail, error_code: #{error_code}");
      else
        @interview.destroy;
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController destroy, interview:#{@interview[:id]} delete success");
      end
    else
      error_code = 'xDBD00001';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController destroy, interview:#{params[:id]} delete fail, error_code: #{error_code}");
    end

    render :json => {:eCode => error_code};
  end # def destroy

####################################################################################################
  def set_positions
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_position")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    success = true;

    i_interview_id = params[:interviewId].to_i;
    us_position_position_ids_add = params[:positionAdd];
    us_position_position_ids_remove = params[:positionRemove];

    i_position_position_ids_add = [];
    i_position_position_ids_remove = [];
    if (!us_position_position_ids_add.nil? && 0 < us_position_position_ids_add.length)
      i_position_position_ids_add = RsasTools.arr_attr_to_int(us_position_position_ids_add);
    end

    if (!us_position_position_ids_remove.nil? && 0 < us_position_position_ids_remove.length)
      i_position_position_ids_remove = RsasTools.arr_attr_to_int(us_position_position_ids_remove);
    end

    if (i_position_position_ids_remove.length)
      i_position_position_ids_remove.each do |i_position_id|
        position = PositionsInInterview.where(:interview_id => i_interview_id, :position_id => i_position_id).first;
        if (position)
          if (position.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, PositionsInInterview:#{position[:id]} delete success");
          else
            success = false;
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, PositionsInInterview: interview_id=#{i_interview_id}, position_id=#{i_position_id},  delete fail");
          end
        end
      end
    end


    if (i_position_position_ids_add.length)
      i_position_position_ids_add.each do |i_position_id|
        position_exist = PositionsInInterview.where(:interview_id => i_interview_id, :position_id => i_position_id).first;
        if (!position_exist)
          position = PositionsInInterview.new_position(i_position_id, i_interview_id);
          if (position[:id])
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, PositionsInInterview:#{position[:id]} create success");
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, PositionsInInterview: interview_id=#{i_interview_id}, position_id=#{i_position_id},  create fail");
            success = false;
          end
        end

      end
    end

    render :json => {:success => success};

  end

####################################################################################################
  def set_interviewers
    permission_to_show, permission_to_active, permission_message = check_user_permission("select_interviewer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    success = true;

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    i_interview_id = params[:interviewId].to_i;
    us_interviewer_user_ids_add = params[:interviewerAdd];
    us_interviewer_user_ids_remove = params[:interviewerRemove];

    #us_sunet_interviewer_add_sunet_ids = params[:sunetInterviewerAddSunetIds];
    us_obj_sunet_interviewer_adds = params[:sunetInterviewerAdd];
    us_sunet_interviewer_remove_user_ids = params[:sunetInterviewerRemoveIds];

    i_interviewer_user_ids_add = [];
    i_interviewer_user_ids_remove = [];
    i_sunet_interviewer_remove_user_ids = [];

    if (us_interviewer_user_ids_add.present?)
      i_interviewer_user_ids_add = RsasTools.arr_attr_to_int(us_interviewer_user_ids_add);
    end

    if (us_interviewer_user_ids_remove.present?)
      i_interviewer_user_ids_remove = RsasTools.arr_attr_to_int(us_interviewer_user_ids_remove);
    end

    if (us_sunet_interviewer_remove_user_ids.present?)
      i_sunet_interviewer_remove_user_ids = RsasTools.arr_attr_to_int(us_sunet_interviewer_remove_user_ids);
    end

    i_total_interviewer_remove_user_ids = i_interviewer_user_ids_remove | i_sunet_interviewer_remove_user_ids;

    manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);

    i_cancel_success_user_ids = []
    if (i_total_interviewer_remove_user_ids.present?)
      i_total_interviewer_remove_user_ids.each do |i_user_id|
        interviewer = Interviewer.where(:interview_id => i_interview_id, :user_id => i_user_id).first;
        if (interviewer)
          if (interviewer.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer:#{interviewer[:id]} delete success");
            i_cancel_success_user_ids << i_user_id;
          else
            success = false;
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer: interview_id=#{i_interview_id}, user_id=#{i_user_id},  delete fail");
          end
        end
      end
    end

    if (i_cancel_success_user_ids.present?)
      Interview.email_at_mgr_cancel_select_interviewer(i_interview_id, i_cancel_success_user_ids, manager_emails);
    end


    not_set_interviewer_user_sunet_ids = [];
    i_select_success_user_ids = [];
    if (i_interviewer_user_ids_add.present?)
      i_interviewer_user_ids_add.each do |i_user_id|
        interviewer = Interviewer.where(:interview_id => i_interview_id, :user_id => i_user_id).first;
        if (interviewer.blank?)
          interviewer = Interviewer.new_interviewer(i_current_process_id, i_user_id, i_interview_id);
          if (interviewer.present?)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer:#{interviewer[:id]} create success");
            i_select_success_user_ids << i_user_id;
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer: interview_id=#{i_interview_id}, user_id=#{i_user_id},  create fail");

            user = User.find_by_id(i_user_id);
            not_set_interviewer_user_sunet_ids << user.sunet_id;
            success = false;
          end
        end
      end
    end

    if (i_select_success_user_ids.present?)
      Interview.email_at_mgr_select_interviewer(i_interview_id, i_select_success_user_ids, manager_emails);
    end

    i_select_sunet_id_success_user_ids = [];

    if (us_obj_sunet_interviewer_adds.present?)
      us_obj_sunet_interviewer_adds.each do |obj_sunet_user|
        s_new_sunet_id = obj_sunet_user[:sunet_id];
        s_new_status = obj_sunet_user[:status];
        s_new_email = obj_sunet_user[:email];
        s_new_first_name = obj_sunet_user[:first_name];
        s_new_middle_name = obj_sunet_user[:middle_name];
        s_new_last_name = obj_sunet_user[:last_name];

        user = User.check_user_or_create(s_new_sunet_id, i_current_year_id, s_new_status, s_new_email, s_new_first_name, s_new_middle_name, s_new_last_name);
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, add sunet_id: #{obj_sunet_user[:sunet_id]}, status: #{obj_sunet_user[:status]}");

        if (user.present?)
          check_applicant = user.applicants.where(:applicants => {:procedure_id => i_current_process_id})
                                     .where.not(:applicants => {:application_submit_at => nil})
                                     .blank?;

          i_user_id = user.id;
          s_sunet_id = user.sunet_id;
          if (check_applicant)
            interviewer = Interviewer.where(:interview_id => i_interview_id, :user_id => i_user_id).first;
            if (interviewer.blank?)
              interviewer = Interviewer.new_sunet_interviewer(i_current_process_id, i_user_id, i_interview_id);
              if (interviewer.present?)
                logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer:#{interviewer[:id]} create success");
                i_select_sunet_id_success_user_ids << i_user_id;
              else
                logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer: interview_id=#{i_interview_id}, user_id=#{i_user_id}, create fail");
                not_set_interviewer_user_sunet_ids << s_sunet_id;
                success = false;
              end
            end
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer: interview_id=#{i_interview_id}, user_sunet_id=#{s_sunet_id} is applicant, create fail");
            not_set_interviewer_user_sunet_ids << s_sunet_id;
            success = false;
          end
        else
          logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview set_interviewers, Interviewer: interview_id=#{i_interview_id}, user_sunet_id=#{sunet_user[:sunet_id]},  create fail");
          not_set_interviewer_user_sunet_ids << obj_sunet_user[:sunet_id];
        end
      end
    end

    if (i_select_sunet_id_success_user_ids.present?)
      Interview.email_at_mgr_select_interviewer(i_interview_id, i_select_sunet_id_success_user_ids, manager_emails);
    end

    render :json => {:success => success, :not_set_interviewer_user_sunet_ids => not_set_interviewer_user_sunet_ids};

  end

####################################################################################################
  def set_invitees
    permission_to_show, permission_to_active, permission_message = check_user_permission("select_applicant")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active


    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    success = true;
    i_mgr_user_id = session[:user_id].to_i;

    i_interview_id = params[:interviewId].to_i;
    us_applicant_user_ids_add = params[:applicantIdAdd];
    us_applicant_user_ids_remove = params[:applicantIdRemove];

    i_applicant_user_ids_add = [];
    i_applicant_user_ids_remove = [];
    if (!us_applicant_user_ids_add.nil? && 0 < us_applicant_user_ids_add.length)
      i_applicant_user_ids_add = RsasTools.arr_attr_to_int(us_applicant_user_ids_add);
    end

    if (!us_applicant_user_ids_remove.nil? && 0 < us_applicant_user_ids_remove.length)
      i_applicant_user_ids_remove = RsasTools.arr_attr_to_int(us_applicant_user_ids_remove);
    end

#    manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);

    i_remove_success_user_ids = [];
    if (i_applicant_user_ids_remove.length)
      i_applicant_user_ids_remove.each do |i_user_id|
        invite = Invite.where(:interview_id => i_interview_id, :invitee_user_id => i_user_id).first;
        if (invite)
          if (invite.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: #{invite[:id]} delete success");

            i_remove_success_user_ids << i_user_id;
          else
            success = false;
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: interview_id=#{i_interview_id}, invitee=#{i_user_id},  delete fail");
          end
        end
      end
    end

#    if i_remove_success_user_ids.present?
#      Interview.email_at_mgr_cancel_select_applicant(i_interview_id, i_remove_success_user_ids, manager_emails);
#    end

    i_invite_success_user_ids = [];
    if (i_applicant_user_ids_add.length)
      i_applicant_user_ids_add.each do |i_user_id|
        invite_exist = Invite.where(:interview_id => i_interview_id, :invitee_user_id => i_user_id).first;
        if (!invite_exist)
          invite = Invite.new_invite(i_interview_id, i_user_id, i_mgr_user_id);
          if (invite[:id])
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: #{invite[:id]} create success");

            i_invite_success_user_ids << i_user_id;
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: interview_id=#{i_interview_id}, invitee=#{i_user_id},  create fail");
            success = false;
          end
        end

      end
    end

#    if i_invite_success_user_ids.present?
#      Interview.email_at_mgr_select_applicant(i_interview_id, i_invite_success_user_ids, manager_emails);
#    end


    render :json => {:success => success};
  end

  def send_invite_email_to_applicants
    permission_to_show, permission_to_active, permission_message = check_user_permission("select_applicant")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    success = false;

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;
    i_interview_id = params[:interviewId].to_i;

    invited_email_subject = params[:invited_email_subject];
    invited_email_content = params[:invited_email_content];
    #canceled_email_subject = params[:canceled_email_subject];
    #canceled_email_content = params[:canceled_email_content];

    manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);
    i_applicant_user_ids = Invite.where(:interview_id => i_interview_id).pluck(:invitee_user_id);

    if (i_applicant_user_ids.present? && invited_email_subject.present? && invited_email_content.present?)
      Interview.email_at_mgr_select_applicant_customized_content(i_interview_id, i_applicant_user_ids, manager_emails, invited_email_subject, invited_email_content);
      success = true;
    end

    render :json => {:success => success};
  end

  def set_time_slots
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_time_slot")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active


    success = true;

    i_interview_id = params[:interviewId].to_i;
    us_time_slot_remove_ids = params[:timeSlotRemoveIds];
    us_time_list = params[:timeList];

    i_time_slot_remove_ids = [];

    if (us_time_slot_remove_ids.present? && 0 < us_time_slot_remove_ids.length)
      i_time_slot_remove_ids = RsasTools.arr_attr_to_int(us_time_slot_remove_ids);
    end

    if (us_time_list.present?)
      us_time_list.each do |time|
        time_parse_start = Time.parse(time[:t_start]);
        time_parse_end = Time.parse(time[:t_end]);
        us_place =  time[:place];
        t_start = Time.utc(time_parse_start.year, time_parse_start.month, time_parse_start.day, time_parse_start.hour, time_parse_start.min);
        t_end = Time.utc(time_parse_end.year, time_parse_end.month, time_parse_end.day, time_parse_end.hour, time_parse_end.min);
        if (time[:timeSlotId].present?)
          i_time_slot_id = time[:timeSlotId].to_i;
          time_slot = TimeSlot.find_by_id(i_time_slot_id);
          time_slot.place = us_place;
          time_slot.t_start = t_start;
          time_slot.t_end = t_end;
          time_slot.save();
        else
          TimeSlot.new_time_slot(i_interview_id, us_place, t_start, t_end)
        end
      end
    end

    logger.info("i_time_slot_remove_ids #{i_time_slot_remove_ids}");

    if (i_time_slot_remove_ids.length)
      i_time_slot_remove_ids.each do |i_time_slot_id|
        time_slot = TimeSlot.find_by_id(i_time_slot_id);
        if (time_slot)
          if (time_slot.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: #{time_slot[:id]} delete success");
          else
            success = false;
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview update, Invite: time_slot_id=#{i_time_slot_id},  delete fail");
          end
        end
      end
    end

    render :json => {:success => success};
  end


####################################################################################################
  def admin_calendar_view
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interview admin_calendar_view, params: #{params}");
    response = [];

    i_round_id = params[:roundId].to_i;

    round = Round.find_by_id(i_round_id);

    manager = current_user();

    if (round)
      include_list = [
                      :interviewers,
                      :time_slots => [
                        :time_slot_interviewers,
                        :interviewees => [
                          :user
                        ]
                      ]
                     ];

      interviews = Interview.includes(include_list)
                            .references(include_list)
                            .where(:round_id => i_round_id)
                            .where(:interviewers => {:user_id => manager.id});

      interviews_list = interviews.as_json({
        :include => [
          {
            :time_slots => {
              :include => [
                :time_slot_interviewers,
                {
                  :interviewees => {
                    :include => [
                      :user => {
                        :methods => :name
                      }
                    ]
                  }
                }
              ]
            }
          },
          :interviewers
        ]
      });

      if (interviews_list.present?)
        interviews_list.each do |interview|
          if (interview["time_slots"].present? && interview["interviewers"])
            interview["time_slots"].each do |time_slot|
              if (time_slot["time_slot_interviewers"].present?)
                time_slot["time_slot_interviewers"].each do |time_slot_interviewer|
                  interview["interviewers"].each do |interviewer|
                    if (interviewer["id"] == time_slot_interviewer["interviewer_id"])
                      time_slot["check"] = true;
                      break;
                    end
                  end
                  if (true == time_slot["check"])
                    break;
                  end
                end

                interviewer_ids = time_slot["time_slot_interviewers"].collect{|time_slot_interviewer| time_slot_interviewer["interviewer_id"]};

                interviewer_users = User.joins(:interviewers)
                                        .where(:interviewers => {:id => interviewer_ids});

                time_slot["interviewer_users"] = interviewer_users.as_json({
                  :methods => :name
                });

              end
            end
          end
        end
      end

      response = interviews_list;
    end

    render :json => response;
  end

####################################################################################################
  def admin_get_interviews
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_admin_page");
    response = {};

    if (permission_to_active)
      table_params = rsas_table_params();
      i_round_id = params[:roundId].to_i;
      i_procedure_id = params[:current_process_id].to_i;
      i_user_id = session[:user_id].to_i;
      response = [];


      b_senior_manager = check_user_permission("SeniorManager")[0];

      logger.info("b_senior_manager : #{b_senior_manager}");

      data = [];

      if (b_senior_manager)
        data = Interview.admin_get_interviews(table_params, i_round_id, i_user_id, b_senior_manager);
      else
        b_middle_manager = check_user_permission("MiddleManager")[0];

        logger.info("b_middle_manager : #{b_middle_manager}");

        #if (b_middle_manager)
          data = Interview.admin_get_interviews_limited_by_position(table_params, i_round_id, i_user_id, b_senior_manager, b_middle_manager);
        #end

      end



      data[:show] = check_admin_interviews_permissions(data[:show]);

      create_permission_to_show, create_permission_to_active, create_permission_message = check_user_permission("interview_create")

      response = {
        :now => data[:now],
        :total => data[:total],
        :show => data[:show],
        :create_permission => create_permission_to_show
      };
    end

    render :json => response;

  end # def admin_all_interview

####################################################################################################
  def check_admin_interviews_permissions(interviews)
    interviews.each do |interview|
      logger.info("interview: #{interview["interviewer_can_edit"]}");

      actions = ["interview_setting", "interview_position", "interview_time_slot", "select_interviewer", "select_applicant", "schedule_interviewer", "schedule_applicant", "interview_delete"];
      all_options = {};
      all_options["interview_time_slot"] = {
        "interviewer_can_edit" => interview["interviewer_can_edit"]
      }
      permission = check_user_permissions(actions, all_options);
      interview[:permissions] = permission;
    end

    return interviews;
  end

####################################################################################################
  def admin_get_my_interviews
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_admin_page")

    response = {};

    if (permission_to_active)
      table_params = rsas_table_params();
      i_round_id = params[:roundId].to_i;
      i_user_id = session[:user_id].to_i;
      response = [];

      data = Interview.admin_get_my_interviews(table_params, i_round_id, i_user_id);

      response = {
        :now => data[:now],
        :total => data[:total],
        :show => data[:show],
      };
    end

    #logger.info(response);

    render :json => response;

  end # def admin_get_my_interviews

####################################################################################################
  def get_procedure_positions
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################

    response = [];
    procedure_positions = [];
    i_procedure_id = params[:p].to_i;

    include_list = [:positions => [:role, :location]];
    if (0 == i_procedure_id)
      procedures = Procedure.all.includes(include_list);
      if (nil == procedures)
        #log_error_message();
      else
        procedures.each do |procedure|
          procedure_positions << procedure.get_procedure_positions;
        end
      end
    else
      procedure = Procedure.includes(include_list).references(include_list).find_by_id(i_procedure_id);
      if (nil == procedure)
        #log_error_message();
      else
        procedure_positions << procedure.get_procedure_positions;
      end
    end

    response = procedure_positions;

    render :json => response;
  end # def get_procedure_positions

####################################################################################################
  def get_procedure_rounds
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################

    response = [];
    procedure_rounds = [];
    i_procedure_id = params[:p].to_i;
    if (0 == i_procedure_id)
      procedures = Procedure.all;
      if (nil == procedures)
        #log_error_message();
      else
        procedures.each do |procedure|
          procedure_rounds << procedure.get_procedure_rounds;
        end
      end
    else
      procedure = Procedure.find_by_id(i_procedure_id);
      if (nil == procedure)
        #log_error_message();
      else
        procedure_rounds << procedure.get_procedure_rounds;
      end
    end

    response = procedure_rounds;

    render :json => response;
  end # def get_procedure_rounds

####################################################################################################
  def get_round_interviews
    response = [];
    round_interviews = [];
    i_round_id = params[:roundId].to_i;

    include_list = [:interviews, :round_tags =>[:role, :location]];
    if (0 == i_round_id)
      rounds = Round.all.includes(include_list);
      if (nil == round)
        #log_error_message();
      else
        rounds.each do |round|
          round_interviews << round.get_round_interviews;
        end
      end
    else
      round = Round.includes(include_list).references(include_list).find_by_id(i_round_id);

      if (nil == round)
        #log_error_message();
      else
        round_interviews << round.get_round_interviews;
      end
    end

    response = round_interviews;

    render :json => response;
  end

####################################################################################################
  def get_round_admin_selected_interviews
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_admin_page")

    response = [];

    i_procedure_id = params[:current_process_id].to_i;

    if (permission_to_active)
      round_interviews = [];
      i_round_id = params[:roundId].to_i;
      i_user_id = session[:user_id].to_i;

      include_list = [:interviews => [:interviewers]];
      if (0 == i_round_id)

      else
        if (is_hiring_mgr(i_procedure_id) || is_admin())
          round = Round.includes(include_list)
                        .references(include_list)
                        .find_by_id(i_round_id);


          if (round.present?)
            round_interviews << round.get_round_interviews;
          end

        else
          round = Round.includes(include_list)
                        .references(include_list)
                        .where(:interviewers => {:user_id => i_user_id})
                        .find_by_id(i_round_id);

          if (round.present?)
            round_interviews << round.get_round_interviews;

            user = User.find_by_id(i_user_id);
            result = Interview.get_mgr_interviews(round, user);
            view_interview_ids = result.view_interview_ids;

            round_interviews.last[:interviews] = Interview.where(:id => view_interview_ids);
          end
        end


      end

      response = round_interviews;
    end


    render :json => response;
  end

####################################################################################################
  def get_one_round
    response = [];
    i_round_id = params[:roundId].to_i;

    round = Round.find_by_id(i_round_id);
    options = {
      :round => round
    };
    permission = {};
    permission["show"], permission["active"], permission["message"] = check_user_permission("ApplicantUnderInterviewRound", options);

    json_round = round.as_json();
    json_round["permission"] = permission;


    response = json_round;

    render :json => response;
  end

####################################################################################################
  def get_positions
    response = [];

    i_procedure_id = params[:current_process_id].to_i;
    i_round_id = params[:round_id].to_i;
    i_mgr_user_id = session[:user_id].to_i;
    i_interview_id = params[:interviewId].to_i;

    position_ids_in_interview = PositionsInInterview.where(:interview_id => i_interview_id).pluck(:position_id);

    positions = [];

    under_manage_location_positions = [];
    under_manage_role_positions = [];


    under_round_location_positions = Position.joins(:location => [:round_tags])
                                             .where(:round_tags => {:round_id => i_round_id});

    under_round_role_positions = Position.joins(:role => [:round_tags])
                                         .where(:round_tags => {:round_id => i_round_id});

    if (is_hiring_mgr(i_procedure_id) || is_admin())
      procedure_positions = Position.where(:procedure_id => i_procedure_id);

      positions = ((procedure_positions && under_round_location_positions) |
                   (procedure_positions && under_round_role_positions));

    else
      under_manage_location_positions = Position.joins(:location => :location_mgrs)
                                                .where(:locations => {:procedure_id => i_procedure_id})
                                                .where(:location_mgrs => {:user_id => i_mgr_user_id});

      under_manage_role_positions = Position.joins(:role => :role_mgrs)
                                            .where(:positions => {:procedure_id => i_procedure_id})
                                            .where(:role_mgrs => {:user_id => i_mgr_user_id});

      positions = ((under_manage_location_positions & under_round_location_positions) |
                   (under_manage_role_positions & under_round_role_positions));
    end

    positions.each do |position|
      response << {
        :id => position.id,
        :name => position.name,
        :check => position_ids_in_interview.include?(position.id)
      }
    end

    render :json => {:positions => response}
  end

####################################################################################################
  def get_interviewers
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################

    i_interview_id = params[:interviewId].to_i;
    i_year_id = params[:current_year_id].to_i;
    # i_position_id = params[:position_id].to_i;
    interviewers = Interview.get_interviewers(i_interview_id, i_year_id);

    sunet_interviewers = Interview.get_sunet_interviewers(i_interview_id);

    render :json => {
      :interviewers => interviewers,
      :sunet_interviewers => sunet_interviewers
    };
  end # def get_interviewers

####################################################################################################
  def get_applicant_list
    # invite
    # this method is interview select applicant list

    # applicant list
    # 0. all
    # 1. Position applicant at these positions
    # 2. All applicant in your control

    # this dropdown select applicant list
    success = true;
    i_interview_id = params[:interviewId].to_i;
    i_mgr_user_id = session[:user_id].to_i;

    interview = Interview.find_by_id(i_interview_id);

    applicant_list = [];
    if (interview)
      procedure_position_applicants = [];
      location_position_applicants = [];
      role_position_applicants = [];
      interview_position_applicants = [];
      interviewers = [];
      offered_applicants = [];

      round_interview = interview.as_json({
        :include => [
          :round
        ]
      });


      interviewers = User.joins(:interviewers)
                         .where(:interviewers => {:interview_id => interview[:id]});

      i_procedure_id = round_interview["round"]["procedure_id"];

      offered_applicants = User.joins(:applicants, :applications)
                               .where(:applicants => {:procedure_id => i_procedure_id})
                               .where(:applicants => {:disqualify => false})
                               .where("applicants.application_submit_at IS NOT NULL")
                               .where(:applications => {:offered => "offered"});


      interview_position_ids = Position.joins(:positions_in_interviews)
                                       .where(:positions_in_interviews => {:interview_id => interview[:id]})
                                       .where(:positions => {:procedure_id => i_procedure_id})
                                       .pluck(:id);

      interview_position_applicants = User.joins(:applicants, :applications)
                                          .where(:applicants => {:procedure_id => i_procedure_id})
                                          .where(:applicants => {:disqualify => false})
                                          .where("applicants.application_submit_at IS NOT NULL")
                                          .where(:applications => {:position_id => interview_position_ids});

      if (is_hiring_mgr(i_procedure_id) || is_admin())
        procedure_position_applicants = User.joins(:applicants)
                                            .where(:applicants => {:procedure_id => i_procedure_id})
                                            .where(:applicants => {:disqualify => false})
                                            .where("applicants.application_submit_at IS NOT NULL");
      else
        location_positions_ids = [];
        role_position_ids = [];

        under_manage_location_positions = Position.joins(:location => :location_mgrs)
                                                  .where(:locations => {:procedure_id => i_procedure_id})
                                                  .where(:location_mgrs => {:user_id => i_mgr_user_id});

        under_manage_role_positions = Position.joins(:role => :role_mgrs)
                                              .where(:positions => {:procedure_id => i_procedure_id})
                                              .where(:role_mgrs => {:user_id => i_mgr_user_id});

        #under_manage_location_positions.each do |position|
        #  location_positions_ids << position.id;
        #end
        location_positions_ids = under_manage_location_positions.collect(&:id);


        #under_manage_role_positions.each do |position|
        #  role_position_ids << position.id;
        #end
        role_position_ids = under_manage_role_positions.collect(&:id);

        location_position_applicants = User.joins(:applicants, :applications)
                                           .where(:applicants => {:procedure_id => i_procedure_id})
                                           .where(:applicants => {:disqualify => false})
                                           .where("applicants.application_submit_at IS NOT NULL")
                                           .where(:applications => {:position_id => location_positions_ids});

        role_position_applicants = User.joins(:applicants, :applications)
                                       .where(:applicants => {:procedure_id => i_procedure_id})
                                       .where(:applicants => {:disqualify => false})
                                       .where("applicants.application_submit_at IS NOT NULL")
                                       .where(:applications => {:position_id => role_position_ids});
      end


      interview_position_applicants = (interview_position_applicants - interviewers) - offered_applicants;
      under_manage_applicants = ((procedure_position_applicants | location_position_applicants | role_position_applicants) - interviewers) - offered_applicants;

      # list one: interview position's applicant
      # list two: applicant who is under manage.
      both_list_applicants = interview_position_applicants & under_manage_applicants;
      only_list_one_applicants = interview_position_applicants - both_list_applicants;
      only_list_two_applicants = under_manage_applicants - both_list_applicants;

      both_list_applicants &= both_list_applicants;
      only_list_one_applicants &= only_list_one_applicants;
      only_list_two_applicants &= only_list_two_applicants;



      invitees = User.joins(:invitees)
                     .where(:invites => {:interview_id => interview[:id]});

      both_list_applicants.each do |applicant|
        applicant_list << applicant_list_struct(applicant, 0, invitees);
      end

      only_list_one_applicants.each do |applicant|
        applicant_list << applicant_list_struct(applicant, 1, invitees);
      end

      only_list_two_applicants.each do |applicant|
        applicant_list << applicant_list_struct(applicant, 2, invitees);
      end

    else
      # no procedure
      # need write log
      success = false;
    end
    #########################################################################################

    render :json => {
      :success => success,
      :applicant_list => applicant_list
    };


  end

####################################################################################################
  def get_interview_applicant_list
    # applicant list
    # 0. all
    # 1. Position applicant at these positions
    # 2. All applicant in your control


    success = true;
    table_params = rsas_table_params();
    i_page = table_params.i_page;
    i_page_count = table_params.i_page_count;
    i_interview_id = params[:interviewId].to_i;
    i_applicant_type = params[:applicantType].to_i;
    i_mgr_user_id = session[:user_id].to_i;

    interview = Interview.find_by_id(i_interview_id);

    applicant_list = [];
    i_total_count = 0;


    b_download_rm_report = false;
    if (interview)
      procedure_position_applicants = [];
      location_position_applicants = [];
      role_position_applicants = [];
      interview_position_applicants = [];
      interviewers = [] ;

      round_interview = interview.as_json({
        :include => [
          :round
        ]
      });

      interviewers = User.interviewer(i_interview_id);
      i_procedure_id = round_interview["round"]["procedure_id"];



      total_show_applicants = [];
      b_senior_manager = false;
      under_manage_location_ids = [];
      under_manage_role_ids = [];
      under_manage_position_ids = Position.get_under_manage_position_ids(i_procedure_id, i_mgr_user_id);

      if (is_hiring_mgr(i_procedure_id) || is_admin())
        b_senior_manager = true;
        b_download_rm_report = true;
      else
        under_manage_location_ids = Location.joins(:location_mgrs)
                               .where(:locations => {:procedure_id => i_procedure_id})
                               .where(:location_mgrs => {:user_id => i_mgr_user_id})
                               .pluck(:id);

        under_manage_role_ids = Role.joins(:role_mgrs)
                       .where(:roles => {:procedure_id => i_procedure_id})
                       .where(:role_mgrs => {:user_id => i_mgr_user_id})
                       .pluck(:id);

        b_download_rm_report = under_manage_role_ids.present?;
      end

      # list one: interview position's applicant
      # list two: applicant who is under manage.
      case (i_applicant_type)
      when 0
        # 1 + 2
        interview_position_ids = interview.position_ids();

        total_show_applicants = (User.get_position_applicants(i_procedure_id, interview_position_ids) |
                                 User.get_under_manage_applicants(i_procedure_id, under_manage_position_ids, b_senior_manager))  - interviewers;
      when 1
        interview_position_ids = interview.position_ids();

        total_show_applicants = User.get_position_applicants(i_procedure_id, interview_position_ids) - interviewers;
      when 2
        total_show_applicants = User.get_under_manage_applicants(i_procedure_id, under_manage_position_ids, b_senior_manager) - interviewers;
      end

      interview_position_applicants = nil;
      under_manage_applicants = nil;
      GC.start();

      total_show_applicants |= total_show_applicants;

      total_show_applicants = total_show_applicants.sort_by{|e| e[:first_name]};

      pagging_show_applicants = Kaminari.paginate_array(total_show_applicants).page(i_page).per(i_page_count);
      i_total_count = pagging_show_applicants.total_count;

      invitees_user_ids = User.joins(:invitees)
                              .where(:invites => {:interview_id => i_interview_id})
                              .pluck(:id);

      pagging_show_applicants.each do |applicant|
        applicant_list << interview_applicant_list_struct(applicant, invitees_user_ids, i_interview_id, i_procedure_id, params[:current_user_status], b_senior_manager,
                                                          under_manage_location_ids, under_manage_role_ids, under_manage_position_ids);
      end

    else
      # no procedure
      # need write log
      success = false;
    end
    #########################################################################################


    render :json => {
      :success => success,
      :now => i_page,
      :total => i_total_count,
      :show => applicant_list,
      :b_download_rm_report => b_download_rm_report
    };
  end

####################################################################################################
  def applicant_list_struct(applicant, i_list_type, invitees)
    # this dropdown select applicant list
    applicant_hash = applicant.as_json();
    applicant_hash[:list_type] = i_list_type;
    applicant_hash[:name] = applicant.name;

    invitees.each do |invitee|
      if (invitee[:id] == applicant[:id])
        applicant_hash[:check] = true;
        break;
      end
    end

    return (applicant_hash);
  end

####################################################################################################
  def interview_applicant_list_struct(user, invitees_user_ids, i_interview_id, i_procedure_id, current_user_status, b_senior_manager,
                                      under_manage_location_ids, under_manage_role_ids, under_manage_position_ids)
    application_forms = [];
    system_forms = [];
    recommendation_forms = [];
    interview_forms = [];
    tags = [];

    i_user_id = user.id;

    #positions = Position.joins(:positions_in_interviews)
    #                    .where(:positions_in_interviews => {:interview_id => i_interview_id});

    application_form_join_list = [:form];

    if (b_senior_manager)
      user_forms = UserForm.select(
                              :id,
                              :form_name
                            )
                            .joins(application_form_join_list)
                            .where(:user_id => i_user_id)
                            .where(:procedure_id => i_procedure_id)
                            .where(:forms => {:form_type => 'Application'})
                            .where(:forms => {:display => true});
      application_forms = user_forms;

    else
      form_ids = [];
      form_ids |= FormTag.where(:location_id => under_manage_location_ids);
      form_ids |= FormTag.where(:role_id => under_manage_role_ids);
      form_ids |= FormTag.where(:position_id => under_manage_position_ids);

      user_forms = UserForm.select(
                              :id,
                              :form_name
                            )
                            .joins(application_form_join_list)
                            .where(:user_id => i_user_id)
                            .where(:procedure_id => i_procedure_id)
                            .where(:forms => {:form_type => 'Application'})
                            .where(:forms => {:display => true})
                            .where(:forms => {:id => form_ids});
      application_forms = user_forms;
    end

    system_form_join_list = [:form];
    system_forms = UserForm.select(
                              :id,
                              :form_name
                            )
                           .joins(system_form_join_list)
                           .where(:user_id => i_user_id)
                           .where(:procedure_id => i_procedure_id)
                           .where(:forms => {:form_type => 'System'})
                           .where(:forms => {:display => true});


    recommendation_form_join_list = [:form_template, :recommendation_form];
    show_for_std_interviewers_condition = current_user_status == "Student" ? {:show_for_std_interviewers => true} : {}
    recommendation_forms = RecommendationRecord.select(
                                                  #'recommendation_records.id',
                                                  'recommendation_records.name as referee',
                                                  'recommendation_records.user_id as candidate_user_id',
                                                  'recommendation_forms.form_name as form_title',
                                                  'recommendation_forms.id'
                                                )
                                               .joins(recommendation_form_join_list)
                                               .where(:user_id => i_user_id)
                                               .where(:procedure_id => i_procedure_id)
                                               .where(:forms => {:display => true})
                                               .where(:disabled => false)
                                               .where(show_for_std_interviewers_condition);

    user_hash = user.as_json();

    user_hash[:name] = user.name;
    user_hash[:applicant_tags] = user.applicant_tags(i_procedure_id);

    if (invitees_user_ids.include?(i_user_id))
      user_hash[:check] = true;
    end


    user_hash[:time_slots] = TimeSlot.includes(:interviewees).where(:interview_id => i_interview_id, :interviewees => {:user_id => i_user_id});
    user_hash[:application_forms] = application_forms;
    user_hash[:system_forms] = system_forms;
    user_hash[:recommendation_forms] = recommendation_forms;
    user_hash[:interview_forms] = interview_forms;

    applicant = Applicant.where(:procedure_id => i_procedure_id, :user_id => i_user_id)
    if check_user_permission("rd_flag_button")[0]
      user_hash[:rd_flag_color] = applicant.pluck(:rd_flag_color).first
    else
      user_hash[:rd_flag_color] = nil
    end

    comments, can_comment = Applicant.get_applicant_comment(applicant.first, current_user, i_procedure_id)

    user_hash[:applicant_id] = applicant.first.id
    user_hash[:comments] = comments
    user_hash[:can_comment] = can_comment

    return (user_hash);
  end

####################################################################################################
  def get_interview_scheduled_applicants
    i_interview_id = params[:interviewId].to_i;

    users = User.includes(:interviewees => [:time_slot => [:interview]])
                .where(:interviews => {:id => i_interview_id});

    users_as_json = users.as_json({
      :methods => :name
    });

    render :json => {
      :applicants => users_as_json
    };


  end

####################################################################################################
  def get_interview_selected_applicants
    i_interview_id = params[:interviewId].to_i;

    users = User.includes(:invitees => [:interview])
                .where(:interviews => {:id => i_interview_id});

    users_as_json = users.as_json({
      :methods => :name
    });

    render :json => {
      :applicants => users_as_json
    };


  end

####################################################################################################
  def get_email_templates
    # interview_mgr_select_applicant
    # interview_mgr_cancel_select_applicant
    # interview_mgr_schedule_applicant
    # interview_mgr_cancel_schedule_applicant

    i_procedure_id = params[:current_process_id].to_i;

    email_types = ['interview_mgr_select_applicant', 'interview_mgr_cancel_select_applicant', 'interview_mgr_schedule_applicant', 'interview_mgr_cancel_schedule_applicant'];

    email_templates = EmailTemplate.where(:procedure_id => i_procedure_id)
                                  .where(:email_type => email_types)
                                  .where(:is_active => true);

    render :json => {
      :email_templates => email_templates
    };


  end


####################################################################################################
  def user_get_interviews
    #######################################################
    # need check connect usr is stenford
    #######################################################



    table_params = rsas_table_params();
    i_user_id = session[:user_id].to_i;
    i_round_id = params[:roundId].to_i;
    response = [];

    data = Interview.user_get_interviews(i_user_id, table_params, i_round_id);

    response = {
      :now => data[:now],
      :total => data[:total],
      :show => data[:show]
      #:permission_to_active => permission_to_active
    };

    #logger.info(response);

    render :json => response;

  end # def user_get_interviews

####################################################################################################
  def user_process_calendar_view
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: InterviewsController user_process_calendar_view, params: #{params}");

    i_user_id = session[:user_id].to_i;
    Interview.set_attr_user_id(i_user_id);
    i_round_id = params[:roundId].to_i;
    time_parse_start = Time.parse(params[:start]);
    time_parse_end = Time.parse(params[:end]);

    t_start = time_parse_start;
    t_end = time_parse_end;




    round = Round.find_by_id(i_round_id);

    if (round)
      i_procedure_id = round.procedure_id;

      include_list = [
        :invites,
        :time_slots,
        :positions_in_interviews => [
          {
            :position => [
              :role,
              :location
            ]
          }
        ]
      ];

      interviews = Interview.includes(include_list)
                            .references(include_list)
                            .where(:round_id => i_round_id)
                            .where(:invites => {:invitee_user_id => i_user_id});

      interviews_as_json = interviews.as_json({
        :methods => :applied,
        :include => [
          {
            :time_slots => {
              :include => [
                :interviewees
              ]
            }
          }

        ]
      });


      response = interviews_as_json;
    end

    #logger.info("response: #{response}");

    render :json => response;

  end # def user_process_calendar_view

####################################################################################################
  def send_email_to_applicants
    permission_to_show, permission_to_active, permission_message = check_user_permission("send_email_to_applicants")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    email_info = params[:email_info];
    email_subject = email_info[:subject];
    email_content = email_info[:content];

    emails = email_info[:recipients].collect{|obj| obj[:email]};
    bcc = email_info[:bcc] ? email_info[:bcc].collect{|obj| obj[:email]} : [];
    cc = email_info[:cc] ? email_info[:cc].collect{|obj| obj[:email]} : [];

    i_count_success = 0;
    error_message = [];
    emails.each do |email|
      send_success = false;
      send_success = StanfordMailer.send_shipped(email, email_subject, email_content, bcc, cc);

      if (send_success.present?)
        logger.info("send_success.present");
        i_count_success += 1;
      else
        message = email.to_s + " email delivery failure.";
        error_message << message;
      end
    end

    success = (emails.length == i_count_success && 0 < i_count_success);
    render :json => {:success => success, :error_message => error_message}
  end

####################################################################################################
  def send_email_to_interviewers
    email_info = params[:email_info];
    email_subject = email_info[:subject];
    email_content = email_info[:content];
    email_content = "Email From: #{current_user.email}<br />" + email_content;

    i_interview_id = email_info[:interview_id].to_i;

    interviewers = User.joins(:interviewers)
                       .where(:interviewers => {:interview_id => i_interview_id});

    send_success = StanfordMailer.send_shipped(interviewers.collect(&:email), email_subject, email_content, [], [], current_user.email);

    if (send_success.present?)
      render :json => {:success => true, :msg => "Email delivery success"}
    else
      render :json => {:success => false, :msg => "Email delivery failure"}
    end
  end

####################################################################################################
  def export_icalendar
    i_round_id = params[:roundId].to_i;

    round = Round.find_by_id(i_round_id);

    manager = current_user();

    interviews_list = [];
    if (round.present? && manager.present?)
      include_list = [
                      :round,
                      :interviewers,
                      :time_slots => [
                        :time_slot_interviewers,
                        :interviewees => [
                          :user
                        ]
                      ]
                     ];

      interviews = Interview.includes(include_list)
                            .references(include_list)
                            .where(:rounds => {:id => i_round_id})
                            .where(:interviewers => {:user_id => manager.id});

      interviews_list = interviews.as_json({
        :include => [
          {
            :time_slots => {
              :include => [
                :time_slot_interviewers,
                {
                  :interviewees => {
                    :include => [
                      :user => {
                        :methods => :name
                      }
                    ]
                  }
                }
              ]
            }
          },
          :interviewers
        ]
      });

      if (interviews_list.present?)
        interviews_list.each do |interview|
          if (interview["time_slots"].present? && interview["interviewers"])
            interview["time_slots"].each do |time_slot|
              if (time_slot["time_slot_interviewers"].present?)
                time_slot["time_slot_interviewers"].each do |time_slot_interviewer|
                  interview["interviewers"].each do |interviewer|
                    if (interviewer["id"] == time_slot_interviewer["interviewer_id"])
                      time_slot["check"] = true;
                      break;
                    end
                  end
                  if (true == time_slot["check"])
                    break;
                  end
                end

                interviewer_ids = time_slot["time_slot_interviewers"].collect{|time_slot_interviewer| time_slot_interviewer["interviewer_id"]};

                interviewer_users = User.joins(:interviewers)
                                        .where(:interviewers => {:id => interviewer_ids});

                time_slot["interviewer_users"] = interviewer_users.as_json({
                  :methods => :name
                });

              end
            end
          end
        end
      end

    end

    cal = Icalendar::Calendar.new

    interviews_list.each do |interview|
      interview_name = interview["name"];

      interview["time_slots"].each do |time_slot|
        s_place = time_slot["place"];
        interviewers = time_slot["interviewer_users"];
        interviewees = time_slot["interviewees"];

        # time_slot t_start: 2016-10-21 11:00:00 UTC
        logger.info("@@ time_slot t_start: #{time_slot['t_start']}");
        logger.info("@@ time_slot t_end: #{time_slot['t_end']}");

        t_start = DateTime.strptime(time_slot["t_start"].to_s, "%Y-%m-%d %H:%M:%S");
        t_end = DateTime.strptime(time_slot["t_end"].to_s, "%Y-%m-%d %H:%M:%S");

        logger.info("@@ t_start: #{t_start}");
        logger.info("@@ t_end: #{t_end}");

        s_summary = "#{interview_name}"
        s_uid = "saasinterview#{i_round_id}_#{interview["id"]}_#{time_slot["id"]}_#{manager.id}"

        s_description = '';
        s_description += interview_name;
        s_description += "\n<place: #{s_place}>";

        if(interviewees.present?)
          s_description += "\n<Applicants>";
          interviewees.each do |interviewee|
            s_description += "\n#{interviewee["user"]["name"]}";
          end
        end

        if(interviewers.present?)
          s_description += "\n<Interviewers>";
          interviewees.each do |interviewer|
            s_description += "\n#{interviewer["user"]["name"]}";
          end
        end

        cal.event do |e|
          e.dtstart     = Icalendar::Values::DateTime.new(t_start);
          e.dtend       = Icalendar::Values::DateTime.new(t_end);
          e.summary     = s_summary;
          e.description = s_description;
          e.ip_class    = "PRIVATE";
          e.uid         = s_uid;
        end

      end
    end


    cal.publish

    filename = "icalendar_#{i_round_id}_#{Time.now.to_i}.ics"
    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename


  end


####################################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find_by_id(params[:id])
    end

end
