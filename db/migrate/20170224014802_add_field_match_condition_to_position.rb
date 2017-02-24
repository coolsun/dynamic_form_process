class AddFieldMatchConditionToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :match_conditions, :text
  end
end
