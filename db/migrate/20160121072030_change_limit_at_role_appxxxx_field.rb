class ChangeLimitAtRoleAppxxxxField < ActiveRecord::Migration
  def change
    remove_column :roles, :offer_appointment, :text, default: "Do you really want to confirm/decline this job offer?\nOnce you confirm a job, you will not be able to accept other jobs."
    add_column    :roles, :offer_appointment, :text, default: "Do you really want to confirm/decline this job offer?\nOnce you confirm a job, you will not be able to accept other jobs."
  end
end





