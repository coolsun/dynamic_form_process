class RoundTags < ActiveRecord::Migration
  def up
    #######################################################################################
    create_table :round_tags do |t|
      t.integer :round_id
      t.integer :location_id
      t.integer :role_id
      t.timestamps
    end
  end

  def down
    drop_table :round_tags
  end
end
