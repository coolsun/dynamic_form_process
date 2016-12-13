class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :applicant_id
      t.text :comment
      t.string :comment_by
      t.timestamps
    end
  end
end
