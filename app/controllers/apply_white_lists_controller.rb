class ApplyWhiteListsController < ApplicationController

  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process Apply White List")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id].to_i
    user_list = ApplyWhiteList.user_list(procedure_id)

    render :json => {:success => true, :apply_white_lists => user_list}
  end

  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process Apply White List")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    year_id = params[:current_year_id].to_i
    procedure_id = params[:current_process_id].to_i

    msg = ApplyWhiteList.create_user_and_white_list(user_params, year_id, procedure_id)
    if msg == "success"
      user_list = ApplyWhiteList.user_list(procedure_id)
      render :json => {:success => true, :apply_white_lists => user_list, :msg => "The apply white list have been created successfully."}
    else
      render :json => {:success => false, :msg => msg}
    end
  end

  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process Apply White List")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id].to_i
    user = User.find_by_id(params[:id])

    if ApplyWhiteList.where(:user_id => user.id, :procedure_id => procedure_id).first.destroy
      user_list = ApplyWhiteList.user_list(procedure_id)
      render :json => {:success => true, :apply_white_lists => user_list, :msg => "The apply white list have been deleted successfully."}
    else
      render :json => {:success => false, :msg => "There was a problem to delete the apply white list."}
    end

  end

  private
    def user_params
      params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :sunet_id)
    end
end
