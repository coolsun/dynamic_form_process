class NewColumnForYearAndApplication < ActiveRecord::Migration
  def change
    add_column :years, :next_year, :string
    add_column :applications, :disable_user_rank, :boolean
    add_column :applications, :disable_mgr_rank, :boolean
  end
end
