class CreateSystemValues < ActiveRecord::Migration
  def change
    create_table :system_values do |t|
      t.string :key
      t.string :value
    end
  end
end
