class AddIndexRoundTags < ActiveRecord::Migration
  def change
    add_index :round_tags, [:round_id, :location_id, :role_id], :unique => true
  end
end
