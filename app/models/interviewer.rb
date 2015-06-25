class Interviewer < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :interview;
  has_many :time_slot_interviewers, :dependent => :destroy;
  has_many :time_slots, :through => :time_slot_interviewers;

  def self.new_interviewer(i_current_process_id, i_user_id, i_interview_id)
    interviewer = Interviewer.new(
      :user_id => i_user_id,
      :interview_id => i_interview_id
    );
    interviewer.save();

    UserProcedure.create(:user_id => i_user_id, :procedure_id => i_current_process_id)
    return (interviewer);
  end

  def self.new_sunet_interviewer(i_current_process_id, i_user_id, i_interview_id)
    interviewer = Interviewer.new(
      :user_id => i_user_id,
      :interview_id => i_interview_id,
      :is_by_sunet_id => true
    );
    interviewer.save();

    UserProcedure.create(:user_id => i_user_id, :procedure_id => i_current_process_id)
    return (interviewer);
  end

  def self.check_managers_interviewer(i_user_id, i_procedure_id)
    managers = ['admin', 'hm', 'rm', 'lm'];
    b_is_manager = User.check_is_manager(managers, i_user_id, i_procedure_id);

    logger.info("b_is_manager : #{b_is_manager}");

    if (b_is_manager.blank?)
      Interviewer.trans_to_sunet_interviewer(i_user_id, i_procedure_id);
    end
  end

  def self.trans_to_sunet_interviewer(i_user_id, i_procedure_id)
    join_list = [
                  :interview => [
                    :round
                  ]
                ];

    interviewers = Interviewer.joins(join_list)
                              .where(:user_id => i_user_id)
                              .where(:rounds => {:procedure_id => i_procedure_id});

    logger.info("interviewers : #{interviewers.to_json}");
    if (interviewers.present?)
      interviewers.each do |interviewer|
        interviewer.is_by_sunet_id = true;
        interviewer.save;
      end
    end
  end

  def position_ids
    i_interview_id = self.id;
    return(
      Position.joins(:positions_in_interviews)
        .where(:positions_in_interviews => {:interview_id => i_interview_id})
        .pluck(:id)
    );
  end

end
