class CreateCommentInLocations < ActiveRecord::Migration
  def change
    create_table :comment_in_locations do |t|
      t.integer :comment_id
      t.integer :location_id
      t.timestamps
    end
  end
end
