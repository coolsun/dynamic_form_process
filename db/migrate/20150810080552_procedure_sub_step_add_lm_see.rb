class ProcedureSubStepAddLmSee < ActiveRecord::Migration
  def change
    add_column :procedure_sub_steps, :lm_see, :boolean, :default => true
  end
end
