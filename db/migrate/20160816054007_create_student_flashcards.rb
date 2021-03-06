class CreateStudentFlashcards < ActiveRecord::Migration
  def change
    create_table :student_flashcards do |t|
      t.integer :year_id
      t.string :suid
      t.string :sunet_id
      t.string :mf
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :location
      t.string :room_space
      t.date :check_in_date
      t.date :check_out_date
      t.string :staff
      t.string :new_or_u
      t.text :image_base64
      t.timestamps
    end

    add_index :student_flashcards, [:year_id, :suid], :unique => true
  end
end
