class InterviewRoundIdFormInputIdIndex < ActiveRecord::Migration
  def change
    add_index :interviews, :round_id
    add_index :form_inputs, :form_id
  end
end
