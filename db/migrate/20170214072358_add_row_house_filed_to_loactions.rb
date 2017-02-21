class AddRowHouseFiledToLoactions < ActiveRecord::Migration
  def change
    add_column :locations, :is_row_house, :boolean, :default => false, :null => false
  end
end
