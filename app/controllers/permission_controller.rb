class PermissionController < ApplicationController

  def get_permission_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("roles_and_permissions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    permission_list = generate_permission_list(params[:current_process_id])

    render :json => {
      :success => true,
      :permission_list => permission_list,
      :permission_to_active => permission_to_active
    }
  end

  def update_permissions
    permission_to_show, permission_to_active, permission_message = check_user_permission("roles_and_permissions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    permission_list = params[:permission_list]
    ProcedureSubStep.update(permission_list.map{|sub_step| sub_step[:sub_step_id]}, permission_list.map{|sub_step| {:lm_see => sub_step[:lm_see]}})

    render :json => {
      :success => true,
      :msg => "The Permission has been updated successfully."
    }
  end

  def insert_substep_roles_and_permissions
    ProcedureStep.where(:name => "Process").each do |ps|
      if !ps.procedure_sub_steps.where(:identify_name => "roles_and_permissions").first
        ProcedureSubStep.create({
          :procedure_step_id => ps.id, :rank => 11, :name => "Roles & Permissions", :identify_name => "roles_and_permissions", :t_start => ps.t_start,
          :t_end => ps.t_end, :enabled => true, :user_view => false, :url_acronym => "roles-and-permissions"
        })
      end
    end

    render :text => "done"
  end

  private
    def generate_permission_list(procedure_id)
      permission_list = []

      ProcedureStep.where(:procedure_id => procedure_id).order(:rank).each do |procedure_step|
        procedure_step.procedure_sub_steps.order(:rank).each do |procedure_sub_step|
          next if procedure_sub_step.identify_name == "applicants"
          premissions = check_user_permission(procedure_sub_step.identify_name, {:return_permission => true})
          if (premissions[:visibility_group] & ["LM Staff", "LM Student"]).present?
            permission_list << {
              :step_name => procedure_step.name,
              :sub_step_name => procedure_sub_step.name,
              :sub_step_id => procedure_sub_step.id,
              :lm_see => procedure_sub_step.lm_see
            }
          end
        end
      end

      return permission_list
    end
end
