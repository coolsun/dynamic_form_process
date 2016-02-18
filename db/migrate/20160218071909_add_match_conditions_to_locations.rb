class AddMatchConditionsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :match_conditions, :text
  end
end
