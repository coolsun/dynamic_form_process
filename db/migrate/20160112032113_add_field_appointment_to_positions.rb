class AddFieldAppointmentToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :appointment, :string, limit: 1024
  end
end









