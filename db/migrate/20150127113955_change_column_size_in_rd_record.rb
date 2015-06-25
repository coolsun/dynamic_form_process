class ChangeColumnSizeInRdRecord < ActiveRecord::Migration
  def change
    change_table :rd_records do |t|
      t.remove :involved_student_id, :involved_student_name
      t.column :involved_student_id, :text
      t.column :involved_student_name, :text
    end
  end
end