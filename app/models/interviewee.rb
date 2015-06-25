class Interviewee < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :time_slot;

=begin
  def self.apply_interview(i_user_id, i_interview_id)
    begin
      interviewee = Interviewee.new(
        :user_id => i_user_id,
        :interview_id =>i_interview_id
      );

      interviewee.save();
      return (interviewee.id);
    rescue ActiveRecord::RecordNotUnique
      return (nil);
    end
  end
=end

  def self.new_interviewee(i_time_slot_id, i_user_id)
    interviewee = Interviewee.create(:time_slot_id => i_time_slot_id, :user_id => i_user_id);
    return interviewee;
  end

  def self.apply(time_slot, i_user_id, i_vacancy)
    success = false;

    interviewee = nil;
    i_has_reserve = Interviewee.where(:time_slot => time_slot.id).count;

    if (i_vacancy > i_has_reserve)
      interviewee = Interviewee.new_interviewee(time_slot.id, i_user_id)
      if (interviewee.present?)
        logger.info("# #{Time.now} action: IntervieweesController create success, interviewee: #{interviewee.to_json}");
        success = true;
      else
        error_code = 'xDBI00003';
        logger.info("# #{Time.now} action: IntervieweesController create fail, database fail, error_code: #{error_code}");
      end
    else
      error_code = 'xIUP00001';
      logger.info("# #{Time.now} action: IntervieweesController create fail, no vacancy, error_code: #{error_code}");
    end


    return OpenStruct.new({
      :success => success,
      :error_code => error_code,
      :interviewee => interviewee
    });
  end


  def self.remove_applicant_procedure_interviewees(i_user_id, i_procedure_id)
    invites = Interviewee.joins(:time_slot => [:interview => [:round]])
                         .where(:user_id => i_user_id)
                         .where(:rounds => {:procedure_id => i_procedure_id});

    invites.delete_all;
  end


  def self.check_has_another_schedule_in_interview(i_interview_id, i_user_id)
    interviewees = Interviewee.joins(:time_slot => [:interview])
                              .where(:user_id => i_user_id)
                              .where(:interviews => {:id => i_interview_id});

    return (interviewees.present?);
  end

end
