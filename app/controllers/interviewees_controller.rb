class IntervieweesController < ApplicationController
  include RsasTools

####################################################################################################
  def create
    error_code = 'xSYS99999';
    success = false;
    i_user_id = session[:user_id].to_i;
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create, params: #{params}");
    i_time_slot_id = params[:timeSlotId].to_i;

    time_slot = TimeSlot.find_by_id(i_time_slot_id);

    if (time_slot.present?)
      t_time_slot_start = time_slot.t_start;
      t_time_slot_end = time_slot.t_end;
      b_check_scheduleing_conflict = User.check_scheduling_conflict(t_time_slot_start, t_time_slot_end, i_user_id);

      if (!b_check_scheduleing_conflict)
        interview = Interview.find_by_id(time_slot.interview_id);
        i_mail_to_user_ids = [];
        i_mail_to_user_ids << i_user_id;
        if (interview.present?)
          i_round_id = interview.round_id;
          round = Round.find_by_id(i_round_id);

          if (round.present?)
            active = nil;
            active = round.is_in_active_time(session[:user_id]);

            if (active)
              i_interview_time_slot_ids = TimeSlot.where(:interview_id => time_slot.interview_id).pluck(:id);
              i_interviewee_time_slot_ids = Interviewee.where(:user_id => i_user_id).pluck(:time_slot_id);

              manager_emails = time_slot.get_related_manager(interview);

              if (i_interview_time_slot_ids == (i_interview_time_slot_ids - i_interviewee_time_slot_ids))
                interviewee = Interviewee.apply(time_slot, i_user_id, interview.vacancy);
                success = interviewee.success;

                if (success)
                  Interview.email_at_applicant_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails);
                  error_code = 'xSYS00000';
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create success, i_user_id #{i_user_id}");
                else
                  error_code = interviewee.error_code;
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create fail, i_user_id #{i_user_id}, error_code: #{error_code}");
                end
              else
                interviewee = Interviewee.apply(time_slot, i_user_id, interview.vacancy);
                success = interviewee.success;
                if (success)
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create success, i_user_id #{i_user_id}");
                  Interview.email_at_applicant_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails);

                  old_interviewees = Interviewee.joins(:time_slot)
                                                .where(:user_id => i_user_id)
                                                .where(:time_slots => {:interview_id => interview.id})
                                                .where.not(:id => interviewee.interviewee.id);

                  if (old_interviewees.present?)
                    old_interviewees.each do |old_interviewee|
                      old_time_slot = TimeSlot.find_by_id(old_interviewee.time_slot_id);
                      Interview.email_at_applicant_cancel_schedule_to_self(i_mail_to_user_ids, old_time_slot, manager_emails);
                    end

                  end
                  result = old_interviewees.delete_all;
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController remove old interviewee success, i_user_id #{i_user_id}, old_interviewees: #{old_interviewees}");
                  error_code = 'xSYS00000';
                else
                  error_code = interviewee.error_code;
                  logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create fail, i_user_id #{i_user_id}, error_code: #{error_code}");
                end

                #error_code = 'xIUP00002';
                #logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create fail, interview_id:#{time_slot.interview_id}, time_slot_id:#{time_slot.id}, error_code: #{error_code}");
              end
            else
              error_code = 'xSYS00009';
              logger.info("# #{Time.now} action: IntervieweesController create fail, it's not time, error_code: #{error_code}");
            end
          else
            error_code = 'xSYS00002';
            logger.info("# #{Time.now} action: IntervieweesController create fail, can't find this round, round_id: #{i_round_id}, error_code: #{error_code}");
          end
        else
          error_code = 'xSYS00004';
          logger.info("# #{Time.now} action: IntervieweesController create fail, can't find this interview, error_code: #{error_code}");
        end
      else
        error_code = 'xSYS00011';
        logger.info("# #{Time.now} action: IntervieweesController create fail, check_scheduling_conflict, error_code: #{error_code}");

      end
    else
      error_code = 'xSYS00003';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController create fail, can't find this time slot, error_code: #{error_code}");
    end

    render :json => {:eCode => error_code, :success => success};
  end #def create


####################################################################################################
  def destroy
    error_code = 'xSYS00000';
    success = false;

    i_time_slot_id = params[:time_slot_id].to_i;
    i_user_id = session[:user_id].to_i;

    interviewee = Interviewee.where(:user_id => i_user_id, :time_slot_id => i_time_slot_id).first;
    time_slot = TimeSlot.find_by_id(i_time_slot_id);

    interview = Interview.find_by_id(time_slot.interview_id);

    if (interview)
      round = Round.find_by_id(interview.round_id);

      if (round)
        active = round.is_in_active_time(session[:user_id]);

        if (active)
          if (interviewee and interviewee.destroy)
            manager_emails = time_slot.get_related_manager();

            i_mail_to_user_ids = [];
            i_mail_to_user_ids << i_user_id;

            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: interviewee destroy, interviewee:#{interviewee.id} delete success");

            Interview.email_at_applicant_cancel_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails);
            success = true;
          else
            error_code = 'xDBD00002';
            logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController destroy, i_time_slot_id:#{i_time_slot_id}, i_user_id:#{i_user_id} delete fail, error_code: #{error_code}");
          end

        else
          error_code = 'xSYS00009';
          logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController destroy fail, it's not time, error_code: #{error_code}");
        end
      else
        error_code = 'xSYS00002';
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController destroy fail, can't find this round, round_id: #{i_round_id}, error_code: #{error_code}");
      end
    else
      error_code = 'xSYS00004';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: IntervieweesController destroy fail, can't find this interview, error_code: #{error_code}");
    end


    render :json => {:eCode => error_code};
  end # def destroy

end
