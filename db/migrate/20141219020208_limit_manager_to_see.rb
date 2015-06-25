class LimitManagerToSee < ActiveRecord::Migration
  def change
    create_table :limit_periods do |t|
      t.integer :procedure_id
      t.datetime  :t_start
      t.datetime  :t_end
      t.timestamps
    end
    add_index :limit_periods, :procedure_id

    create_table :limit_managers do |t|
      t.integer :limit_period_id
      t.integer :role_id
      t.integer :location_id
      t.timestamps
    end
    add_index :limit_managers, :limit_period_id
  end
end
