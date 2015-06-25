class CreateApplyWhiteList < ActiveRecord::Migration
  def change
    create_table :apply_white_lists do |t|
      t.integer :procedure_id
      t.integer :user_id
    end
    add_index :apply_white_lists, [:procedure_id, :user_id], :unique => true
    add_index :apply_white_lists, [:user_id, :procedure_id], :unique => true
  end
end