class TimeSlotsController < ApplicationController
  include RsasTools


####################################################################################################
  def create
  end # def create

####################################################################################################
  def update
    success = true;
    error_code = 'xSYS00000';
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController update, params: #{params}");



    i_time_slot_id = params[:id].to_i;
    us_place = params[:place];
    us_t_start = params[:t_start];
    us_t_end = params[:t_end];


    time_parse_start = Time.parse(us_t_start);
    time_parse_end = Time.parse(us_t_end);
    t_start = Time.utc(time_parse_start.year, time_parse_start.month, time_parse_start.day, time_parse_start.hour, time_parse_start.min);
    t_end = Time.utc(time_parse_end.year, time_parse_end.month, time_parse_end.day, time_parse_end.hour, time_parse_end.min);

    time_slot = TimeSlot.find_by_id(i_time_slot_id);

    update_data = {
      :place => us_place,
      :t_start => t_start,
      :t_end => t_end,
    }


    if (time_slot.update(update_data))
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController update, time_slot: #{params[:id]} update success");
    else
      error_code = 'xDBU00002';
      success = false;
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController update, time_slot: #{params[:id]} update fail, error_code: #{error_code}");
    end

    render :json => {
      :success => success,
      :eCode => error_code
    };




  end # def update


####################################################################################################
  def destroy

  end # def destroy


####################################################################################################
  def get_interviewers
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################

    i_time_slot_id = params[:timeSlotId].to_i;
    time_slot = TimeSlot.find_by_id(i_time_slot_id);

    interviewers = [];
    if (time_slot)
      interview_interviewers = User.includes(:interviewers)
                                   .where(:interviewers => {:interview_id => time_slot[:interview_id]});

      time_slot_interviewers = User.includes(:interviewers, :time_slot_interviewers)
                                   .where(:time_slot_interviewers => {:time_slot_id => time_slot[:id]});

      interviewees = User.joins(:interviewees)
                         .where(:interviewees => {:time_slot_id => time_slot[:id]});

      as_interviewers = interview_interviewers - interviewees;

      as_interviewers &= as_interviewers;

      as_interviewers.each do |user|
        b_is_interviewer = false;
        time_slot_interviewers.each do |interviewer|
          if (user.id == interviewer.id)
            b_is_interviewer = true;
            break;
          end
        end
        user_hash = user.as_json({
          :include => [
            :interviewers
          ]
        });
        user_hash[:name] = user.name;
        user_hash[:check] = b_is_interviewer;
        interviewers << user_hash;

      end

    end


    render :json => interviewers;
  end


####################################################################################################
  def set_interviewers
    permission_to_show, permission_to_active, permission_message = check_user_permission("schedule_interviewer")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active


    success = false;

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    i_time_slot_id = params[:timeSlotId].to_i;
    us_interviewer_ids_add = params[:interviewerAdd];
    us_interviewer_ids_remove = params[:interviewerRemove];

    time_slot = TimeSlot.find_by_id(i_time_slot_id);
    interview = Interview.find_by_id(time_slot.interview_id);
    render :json => {:success => false, :msg => 'Insufficient privileges'} and return if !interview.interviewer_can_schedule;

    i_time_slot_id = time_slot.id;
    i_interview_id = time_slot.interview_id;

    i_interviewer_ids_add = [];
    i_interviewer_ids_remove = [];
    #not_set_interviewer_ids = [];
    not_set_interviewer_users = [];

    if (!us_interviewer_ids_add.nil? && 0 < us_interviewer_ids_add.length)
      i_interviewer_ids_add = RsasTools.arr_attr_to_int(us_interviewer_ids_add);
    end

    if (!us_interviewer_ids_remove.nil? && 0 < us_interviewer_ids_remove.length)
      i_interviewer_ids_remove = RsasTools.arr_attr_to_int(us_interviewer_ids_remove);
    end

    manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);

    i_cancel_success_interviewer_ids = [];
    if (i_interviewer_ids_remove.present?)
      i_interviewer_ids_remove.each do |i_interviewer_id|
        time_slot_interviewer = TimeSlotInterviewer.where(:time_slot_id => i_time_slot_id, :interviewer_id => i_interviewer_id).first;
        if (time_slot_interviewer)
          if (time_slot_interviewer.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewers, Interviewer:#{time_slot_interviewer[:id]} delete success");
            success = true;

            i_cancel_success_interviewer_ids << i_interviewer_id;
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewers, Interviewer: :time_slot_id=#{i_time_slot_id}, :interviewer_id=#{i_interviewer_id},  delete fail");
          end
        end
      end
    else
      success = true;
    end

    if (i_cancel_success_interviewer_ids.present?)
      i_cancel_success_user_ids = User.joins(:interviewers)
                                      .where(:interviewers => {:id => i_cancel_success_interviewer_ids})
                                      .pluck(:id);

      Interview.email_at_mgr_cancel_schedule_interviewer(i_cancel_success_user_ids, time_slot, manager_emails);
    end



    i_schedule_success_interviewer_ids = [];
    interviewer_ids_add_length = i_interviewer_ids_add.length;
    if (interviewer_ids_add_length)
      #interview = Interview.find_by_id(time_slot.interview_id);

      run_add = false;
      if (interview.interviewer_can_schedule)
        count_scheduled_time_slot_interviewers = TimeSlotInterviewer.where(:time_slot_id => i_time_slot_id).count;
        interviewer_vacancy = interview.interviewer_vacancy;
        remain_vacancy = interviewer_vacancy - count_scheduled_time_slot_interviewers;

        if (interviewer_ids_add_length <= remain_vacancy)
          run_add = true;
        end
      else
        run_add = true;
      end

      if (run_add)
        max_time_slot_per_interviewer = interview.max_time_slot_per_interviewer;

        interviewers = Interviewer.includes(:user)
                                  .where(:interviewers => {:id => i_interviewer_ids_add});

        interviewers_as_json = interviewers.as_json({
          :include => [
            {
              :user => {
                :methods => :name
              }
            }
          ]
        });

        interviewers_as_json.each do |interviewer|
        #i_interviewer_ids_add.each do |i_interviewer_id|
          i_interviewer_id = interviewer["id"];
          user = interviewer["user"];
          i_user_id = user["id"];

          t_time_slot_start = time_slot.t_start;
          t_time_slot_end = time_slot.t_end;
          b_check_scheduleing_conflict = User.check_scheduling_conflict(t_time_slot_start, t_time_slot_end, i_user_id);

          if (!b_check_scheduleing_conflict)
            time_slot_interviewer = TimeSlotInterviewer.where(:time_slot_id => i_time_slot_id, :interviewer_id => i_interviewer_id).first;
            if (time_slot_interviewer.blank?)
              count_sign_up_time_slot = TimeSlotInterviewer.where(:interviewer_id => i_interviewer_id).count;

              if (count_sign_up_time_slot < max_time_slot_per_interviewer)
                time_slot_interviewer = TimeSlotInterviewer.new_time_slot_interviewer(i_time_slot_id, i_interviewer_id);
                if (time_slot_interviewer)
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewers, Interviewer:#{time_slot_interviewer[:id]} create success");
                  i_schedule_success_interviewer_ids << i_interviewer_id;
                else
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewers, Interviewer: :time_slot_id=#{i_time_slot_id}, interviewer_id=#{i_interviewer_id},  create fail");
                  not_set_interviewer_users << user;
                end
              else
                #not_set_interviewer_ids << i_interviewer_id;
                logger.info("# #{Time.now} action: TimeSlotsController set_interviewers fail, count_sign_up_time_slot < max_time_slot_per_interviewer, user: #{user}");
                not_set_interviewer_users << user;
              end
            else
              # do nothing, has been time slot interviewer.
            end
          else
            not_set_interviewer_users << user;
            logger.info("# #{Time.now} action: TimeSlotsController set_interviewers fail, check_scheduling_conflict, user: #{user}");
          end
        end
      end
    end

    if (i_schedule_success_interviewer_ids.present?)
      i_schedule_success_user_ids = User.joins(:interviewers)
                                      .where(:interviewers => {:id => i_schedule_success_interviewer_ids})
                                      .pluck(:id);

      Interview.email_at_mgr_schedule_interviewer(i_schedule_success_user_ids, time_slot, manager_emails);
    end


    success = (not_set_interviewer_users.present?)? false : success;


    render :json => {:success => success, :not_set_interviewer_users => not_set_interviewer_users};

  end

####################################################################################################
  def get_applicant_list
    success = true;
    i_time_slot_id = params[:timeSlotId].to_i;

    time_slot = TimeSlot.find_by_id(i_time_slot_id);

    applicant_list = [];
    if (time_slot)
      invitees = User.joins(:invitees).where(:invites => {:interview_id => time_slot[:interview_id]});
      interviewee_user_ids = User.joins(:interviewees).where(:interviewees => {:time_slot_id => time_slot[:id]}).pluck(:user_id);

      invitees &= invitees;

      invitees.each do |user|
        user_hash = user.as_json;
        user_hash[:name] = user.name;
        user_hash[:check] = interviewee_user_ids.include?(user.id);

        applicant_list << user_hash;
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
  def set_interviewees
    permission_to_show, permission_to_active, permission_message = check_user_permission("schedule_applicant")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    success = true;
    i_time_slot_id = params[:timeSlotId].to_i;
    us_applicant_user_ids_add = params[:applicantIdAdd];
    us_applicant_user_ids_remove = params[:applicantIdRemove];

    time_slot = TimeSlot.find_by_id(i_time_slot_id);
    i_interview_id = time_slot.interview_id;

    #not_set_interviewee_user_ids = [];
    not_set_interviewee_users = [];

    i_applicant_user_ids_add = [];
    i_applicant_user_ids_remove = [];
    if (!us_applicant_user_ids_add.nil? && 0 < us_applicant_user_ids_add.length)
      i_applicant_user_ids_add = RsasTools.arr_attr_to_int(us_applicant_user_ids_add);
    end

    if (!us_applicant_user_ids_remove.nil? && 0 < us_applicant_user_ids_remove.length)
      i_applicant_user_ids_remove = RsasTools.arr_attr_to_int(us_applicant_user_ids_remove);
    end

    manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);

    i_cancel_success_user_ids = [];
    if (i_applicant_user_ids_remove.length)
      i_applicant_user_ids_remove.each do |i_user_id|
        interviewee = Interviewee.where(:time_slot_id => i_time_slot_id, :user_id => i_user_id).first;
        if (interviewee)
          if (interviewee.destroy)
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewees, interviewee: #{interviewee[:id]} delete success");
            i_cancel_success_user_ids << i_user_id;
          else
            success = false;
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewees, interviewee: time_slot_id=#{i_time_slot_id}, user_id=#{i_user_id},  delete fail");
          end
        end
      end
    end

    if (i_cancel_success_user_ids.present?)
      Interview.email_at_mgr_cancel_schedule_applicant(i_cancel_success_user_ids, time_slot, manager_emails);
    end



    i_schedule_success_user_ids = [];
    if (i_applicant_user_ids_add.length)
      applicant_users = User.where(:id => i_applicant_user_ids_add);

      logger.info("applicant_users: #{applicant_users.to_json}");

      applicant_users_as_json = applicant_users.as_json({
        :methods => :name
      });

      applicant_users_as_json.each do |user|
      #i_applicant_user_ids_add.each do |i_user_id|
        i_user_id = user["id"];

        t_time_slot_start = time_slot.t_start;
        t_time_slot_end = time_slot.t_end;
        b_check_scheduleing_conflict = User.check_scheduling_conflict(t_time_slot_start, t_time_slot_end, i_user_id);

        logger.info("b_check_scheduleing_conflict: #{b_check_scheduleing_conflict}");

        if (!b_check_scheduleing_conflict)
          has_schedule = Interviewee.where(:time_slot_id => i_time_slot_id, :user_id => i_user_id).first;

          if (has_schedule.blank?)
            logger.info("has_schedule: #{has_schedule}");

            if (Interviewee.check_has_another_schedule_in_interview(i_interview_id, i_user_id))
              logger.info("# #{Time.now} action: TimeSlotsController set_interviewees fail, check_has_another_schedule_in_interview, user: #{user}");
              #not_set_interviewee_user_ids << i_user_id;
              not_set_interviewee_users << user;
            else
              interviewee = Interviewee.new_interviewee(i_time_slot_id, i_user_id);
              if (interviewee.present?)
                logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewees, interviewee: #{interviewee[:id]} create success");
                i_schedule_success_user_ids << i_user_id;
              else
                logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotsController set_interviewees, interviewee: time_slot_id=#{i_time_slot_id}, user_id=#{i_user_id},  create fail");
                success = false;
              end
            end
          end
        else
          not_set_interviewee_users << user;
          logger.info("# #{Time.now} action: TimeSlotsController set_interviewees fail, check_scheduling_conflict, user: #{user}");
        end
      end
    end

    if (i_schedule_success_user_ids.present?)
      Interview.email_at_mgr_schedule_applicant(i_schedule_success_user_ids, time_slot, manager_emails);
    end

    success = (not_set_interviewee_users.present?)? false : success;

    logger.info("success : #{success}");
    render :json => {:success => success, :not_set_interviewee_users => not_set_interviewee_users};
  end

end









