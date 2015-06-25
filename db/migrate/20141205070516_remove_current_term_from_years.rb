class RemoveCurrentTermFromYears < ActiveRecord::Migration
  def change
    remove_column :years, :current_term
  end
end
