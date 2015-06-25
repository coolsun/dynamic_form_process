class TimeSlotInterviewer < ActiveRecord::Base
  has_paper_trail

#  belongs_to :user;
#  belongs_to :interview;
  belongs_to :time_slot;
  belongs_to :interviewer;


  def self.new_time_slot_interviewer(i_time_slot_id, i_interviewer_id)
    time_slot_interviewer = TimeSlotInterviewer.new(
      :time_slot_id => i_time_slot_id,
      :interviewer_id => i_interviewer_id
    );
    time_slot_interviewer.save();
    return (time_slot_interviewer);
  end
end
