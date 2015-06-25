class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Create role")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = rsas_table_params.i_procedure_id

    role_ids_condition = {}
    if is_admin || is_hiring_mgr(procedure_id)
    else
      role_ids_condition = {:id => current_user_role_mgr_role_ids_in_procedure(procedure_id)}
    end

    role_list, roles_total = Role.get_role_list(rsas_table_params, role_ids_condition)

    render :json => {
      :now => params[:page],
      :total => roles_total,
      :show => role_list,
      :success => true,
      :permission_to_active => permission_to_active
    }
  end

  # POST /roles
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Create role")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    role = Role.create(role_params)
    if role.errors.any?
      render :json => {:success => false, :msg => get_error_messages(role)}
    elsif role
      render :json => {:success => true, :msg => "The role has been created successfully.", :role => role}
    else
      render :json => {:success => false, :msg => "Failed to create the role."}
    end
  end

  # PATCH/PUT /roles/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    role_ids = current_user_role_mgr_role_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!@role.id.in?(role_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    @role.update(role_params)
    if @role.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@role)}
    elsif @role
      render :json => {:success => true, :msg => "The role has been updated successfully.", :role => @role}
    else
      render :json => {:success => false, :msg => "There was a problem to update the role."}
    end
  end

  # DELETE /roles/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    role_ids = current_user_role_mgr_role_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!@role.id.in?(role_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    @role.destroy
    if @role.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@role)}
    elsif @role
      render :json => {:success => true, :msg => "The role has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the role."}
    end
  end

  private
    def set_role
      @role = Role.find_by_id(params[:id])
    end
    def role_params
      params.require(:role).permit(:procedure_id, :name, :tag, :description)
    end
end
