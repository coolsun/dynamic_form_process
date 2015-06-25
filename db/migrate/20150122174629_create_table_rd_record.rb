class CreateTableRdRecord < ActiveRecord::Migration
  def change
    create_table :rd_records do |t|
      t.integer :user_id
      t.string :case_id
      t.string :primary_student_id
      t.string :primary_student_name
      t.string :involved_student_id
      t.string :involved_student_name
      t.string :case_type
      t.string :created_date
      t.timestamps
    end
    add_index :rd_records, :user_id
  end
end