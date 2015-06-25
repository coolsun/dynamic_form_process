class AddNameToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :name, :string
  end
end
