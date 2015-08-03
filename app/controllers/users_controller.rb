class UsersController < ApplicationController
  require 'rest_client'

  before_action :set_user, only: [:show, :edit, :update]


  # GET /users
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process User")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    user_list, users_total = User.get_user_list(rsas_table_params)

    render :json => {
      :now => params[:page],
      :total => users_total,
      :show => user_list,
      :permission_to_active => permission_to_active
    }
  end

  # POST /users
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process User")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    user = User.where(:sunet_id => user_params[:sunet_id], :year_id => user_params[:year_id]).first
    if user
      user.update(user_params)
    else
      user = User.create(user_params)
    end

    if user.errors.any?
      render :json => {:success => false, :msg => get_error_messages(user)}
    elsif user
      user_procedure_params = {:user_id => user.id, :procedure_id => params[:current_process_id]}
      user_procedure = UserProcedure.where(user_procedure_params).first
      if user_procedure
        render :json => {:success => false, :msg => "This user already exists."}
      else
        UserProcedure.create(user_procedure_params)
        render :json => {:success => true, :msg => "The user has been created successfully."}
      end
    else
      render :json => {:success => false, :msg => "Failed to create the user."}
    end
  end

  # PATCH/PUT /users/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process User")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    if @user.update(update_user_params)
      i_procedure_id = params[:current_process_id].to_i;
      i_user_id = @user.id;
      Interviewer.check_managers_interviewer(i_user_id, i_procedure_id);

      render :json => {:success => true, :user => @user, :msg => "The user has been updated successfully."}
    elsif @user.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@user)}
    else
      render :json => {:success => false, :msg => "There was a problem to update the user."}
    end
  end

  # DELETE /users/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process User")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    user = User.find_by_id(params[:id])
    if user.is_admin
      render :json => {
        :success => false,
        :msg => "You are not able to delete admins. If you really want to delete this admin, please go to ''Edit'' to cancel his/her admin permission first and try again."
      } and return
    end

    user_procedure = UserProcedure.where(:user_id => params[:id], :procedure_id => params[:current_process_id]).first
    user_procedure.destroy
    if user_procedure.errors.any?
      render :json => {:success => false, :msg => get_error_messages(user_procedure)}
    elsif user_procedure
      render :json => {:success => true, :msg => "The user has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the user."}
    end
  end

  def remove_user
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process User")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    user = User.find_by_id(params[:user_id])
    if user.is_admin
      render :json => {
        :success => false,
        :msg => "You are not able to delete admins. If you really want to delete this admin, please go to ''Edit'' to cancel his/her admin permission first and try again."
      } and return
    end

    user.destroy
    if user.errors.any?
      render :json => {:success => false, :msg => get_error_messages(user)}
    elsif user
      render :json => {:success => true, :msg => "The user has been removed successfully."}
    else
      render :json => {:success => false, :msg => "Failed to remove the user."}
    end

  end

  def logout
    session[:user_id] = nil
    render :json => {:success => true}
  end

  def get_user_authority
    session_user_id = session[:user_id];
    params_user_id = params[:user_id];

    user = User.get_and_check_user_authority(session_user_id, params_user_id, nil, is_admin());

    if user
      session[:user_id] = user.id
      permissions = get_header_permission();

      render :json => {
        :success => true,
        :authorities => user,
        :permissions => permissions
      }
    else
      logger.info "== login failed =="
      render :json => {:success => false}
    end
  end

  def get_user_all
    year_id = params[:current_year_id]
    year = Year.find_by_id(year_id) if year_id
    year = Year.find_by_current_year(true) if !year

    users = User.where(:year_id => year.id).order(:first_name)

    render :json => {
      :users => users.as_json(:methods => :name)
    }
  end

  def check_user_manager
    i_user_id = session["user_id"].to_i;
    i_procedure_id = params[:current_process_id].to_i;
    mgr_positions = ['admin', 'hm', 'rm', 'lm'];

    b_is_manager = User.check_is_manager(mgr_positions, i_user_id, i_procedure_id)

    render :json => {
      :isManager => b_is_manager
    }
  end

  private
    def set_user
      @user = User.find_by_id(params[:id])
    end
    def user_params
      params.require(:user).permit(:status, :is_admin, :first_name, :middle_name, :last_name, :email, :sunet_id, :year_id)
    end
    def update_user_params
      params.require(:user).permit(:status, :is_admin, :first_name, :middle_name, :last_name, :email, :sunet_id)
    end
end
