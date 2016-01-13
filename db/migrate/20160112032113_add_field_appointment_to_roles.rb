class AddFieldAppointmentToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :offer_appointment, :string, limit: 1024, default: "Do you really want to confirm/decline this job offer?\nOnce you confirm a job, you will not be able to accept other jobs."
  end
end









