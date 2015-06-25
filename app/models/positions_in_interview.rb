class PositionsInInterview < ActiveRecord::Base
  has_paper_trail

  belongs_to :position;
  belongs_to :interview;


  def self.multiple_create(i_interview_id, i_position_ids)
    i_position_ids.each do |i_position_id|
      check = PositionsInInterview.where(:interview_id => i_interview_id, :position_id => i_position_id).first;
      if (check.blank?)
        PositionsInInterview.create(:interview_id => i_interview_id, :position_id => i_position_id);
      end
    end
  end

  def self.new_position(i_position_id, i_interview_id)
    position = PositionsInInterview.new(
      :position_id => i_position_id,
      :interview_id => i_interview_id
    );
    position.save();
    return (position);
  end
end
