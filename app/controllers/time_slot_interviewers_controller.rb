class TimeSlotInterviewersController < ApplicationController
  include RsasTools


####################################################################################################
  def create
    # this method is interviewer sign up by self
    error_code = 'xSYS99999';
    success = false;
    i_user_id = session[:user_id].to_i;
    i_time_slot_id = params[:timeSlotId].to_i;
    i_interviewer_id = params[:interviewerId].to_i;

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    time_slot = TimeSlot.find_by_id(i_time_slot_id);
    interview = Interview.find_by_id(time_slot.interview_id);
    render :json => {:success => false, :msg => 'Insufficient privileges'} and return if !interview.interviewer_can_schedule;

    message = '';

    if (time_slot.present?)
      t_time_slot_start = time_slot.t_start;
      t_time_slot_end = time_slot.t_end;
      b_check_scheduleing_conflict = User.check_scheduling_conflict(t_time_slot_start, t_time_slot_end, i_user_id);

      if (!b_check_scheduleing_conflict)

        i_interview_id = time_slot.interview_id;
        #interview = Interview.find_by_id(i_interview_id);

        if (interview.present?)
          if (interview.interviewer_can_schedule)
            count_interviewer_has_sign_up = TimeSlotInterviewer.where(:time_slot_interviewers => {:interviewer_id => i_interviewer_id}).count;

            interviewer_max_sign_up = interview.max_time_slot_per_interviewer;

            count_scheduled_time_slot_interviewers = TimeSlotInterviewer.where(:time_slot_id => i_time_slot_id).count;

            interviewer_vacancy = interview.interviewer_vacancy;

            if (count_interviewer_has_sign_up < interviewer_max_sign_up)
              if (count_scheduled_time_slot_interviewers < interviewer_vacancy)
                time_slot_interviewer = TimeSlotInterviewer.new_time_slot_interviewer(i_time_slot_id, i_interviewer_id);

                if (time_slot_interviewer.present?)
                  i_mail_to_user_ids = [];
                  i_mail_to_user_ids << i_user_id;

                  manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);
                  Interview.email_at_interviewer_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails);

                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, success");
                  error_code = 'xSYS00000';
                  success = true;
                else
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, params: #{params.to_json}");
                  error_code = 'xDBI00008';
                  message = "sign up fail, please try again.";
                end
              else
                logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, this interview has no vacancy for interviewer.");
                error_code = 'xSYS00005';
                message = "There is no interviewer vacancy in this interview currently.";
              end
            else
              logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, num of signed up has too many.");
              error_code = 'xSYS00005';
              message = "An interviewer can sign up only #{interviewer_max_sign_up} time slot in this interview.";
            end
          else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, this interview can't schedule by interviewer self.");
            error_code = 'xSYS00004';
            message = "This interview is not allow interviewer schedule by self.";
          end
        else
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, can't find this interview which id is {i_interview_id}.");
            error_code = 'xSYS00004';
            message = "lose interview.";
        end
      else
        error_code = 'xSYS00011';
        logger.info("# #{Time.now} action: TimeSlotInterviewersController create fail, check_scheduling_conflict, error_code: #{error_code}");
        message = "It's scheduling conflict. Please check schedule.";
      end
    else
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: TimeSlotInterviewersController create, fail, can't find this time slot which id is {i_time_slot_id}.");
      error_code = 'xSYS00003';
      message = "lose time slot.";
    end

    render :json => {
      :eCode => error_code,
      :success => success,
      :message => message
    };
  end #def create


####################################################################################################
  def destroy
    # this method is interviewer unsign by self
    error_code = 'xSYS00000';
    success = true;

    i_current_year_id = params[:current_year_id].to_i;
    i_current_process_id = params[:current_process_id].to_i;

    i_user_id = session[:user_id].to_i;
    i_time_slot_interviewer_id = params[:id].to_i;

    time_slot_interviewer = TimeSlotInterviewer.find_by_id(i_time_slot_interviewer_id);

    if (time_slot_interviewer and time_slot_interviewer.destroy)
      i_time_slot_id = time_slot_interviewer.time_slot_id;
      time_slot = TimeSlot.find_by_id(i_time_slot_id);
      interview = Interview.find_by_id(time_slot.interview_id);
      render :json => {:success => false, :msg => 'Insufficient privileges'} and return if !interview.interviewer_can_schedule;


      i_interview_id = time_slot.interview_id;

      i_mail_to_user_ids = [];
      i_mail_to_user_ids << i_user_id;

      manager_emails = Procedure.admin_and_hiring_mgr_emails(i_current_process_id);
      Interview.email_at_interviewer_cancel_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails);

      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interviewee destroy success, time_slot_interviewer id #{i_time_slot_interviewer_id} delete success");
    else
      error_code = 'xDBD00006';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interviewee destroy fail, i_time_slot_interviewer_id #{i_time_slot_interviewer_id}");
      success = false;
    end

    render :json => {
      :success => success,
      :eCode => error_code
    };
  end # def destroy


end
