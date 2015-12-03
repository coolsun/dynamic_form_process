class AddFieldScheduleDueDayToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :schedule_due_time, :datetime
  end
end
