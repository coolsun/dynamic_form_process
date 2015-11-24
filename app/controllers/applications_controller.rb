class ApplicationsController < ApplicationController

  def get_select_position_list
    procedure_id = params[:current_process_id]
    if params[:sub_step] == "select_position"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Select Position")
    else
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Post Match Select Position")
    end

    remaining_year = User.find_by_id(session[:user_id]).academic_year_remaining
    select_position_list = Position.get_select_position_list(procedure_id, session[:user_id], params[:sub_step])
    select_position_limit = Procedure.find_by_id(procedure_id).select_position_limit
    roles = Role.where(:procedure_id => procedure_id)
    locations = Location.where(:procedure_id => procedure_id)
    one_year_up_message = SystemMessage.where(:procedure_id => procedure_id, :identify_name => "one_year_up").first.try(:message)

    render :json => {
      :positions => select_position_list,
      :roles => roles,
      :locations => locations,
      :select_position_limit => select_position_limit,
      :permission_to_active => permission_to_active,
      :one_year_up_message => one_year_up_message,
      :remaining_year => remaining_year
    }
  end

  def update_positions_select
    procedure_id = params[:current_process_id]
    begin
      if params[:sub_step] == "select_position"
        permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Select Position")
      else
        permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Post Match Select Position")
      end
      if permission_to_active
        success, msg, new_create_position_ids = Application.update_positions_select(current_user.id, procedure_id, params[:add_ids] || [], params[:delete_ids] || [])
        render :json => {:success => success, :msg => msg}
      else
        render :json => {:success => false, :msg => permission_message}
      end
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "Failed to select the position."}
    end
  end

=begin
  def get_applicants_detail
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Select Position")
    select_position_list = Position.get_select_position_list(params[:current_process_id], session[:user_id])
    render :json => {:positions => select_position_list, :permission_to_active => permission_to_active}
  end
=end

  def get_select_position_settings
    permission_to_show, permission_to_active, permission_message = check_user_permission("select_position")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    select_position_settings = {}
    select_position_limit = Procedure.find_by_id(params[:current_process_id]).select_position_limit
    select_position_settings = {
      :select_position_limit => select_position_limit
    }
    render :json => {:success => true, :select_position_settings => select_position_settings, :permission_to_active => permission_to_active}
  end

  def update_select_position_settings
    permission_to_show, permission_to_active, permission_message = check_user_permission("select_position")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    select_position_settings = params[:select_position_settings]
    if Procedure.update(params[:current_process_id], :select_position_limit => select_position_settings[:select_position_limit])
      render :json => {:success => true, :msg => "The position settings have been updated successfully."}
    else
      render :json => {:success => false, :msg => "There was a problem to update the position settings."}
    end
  end

  def manual_positions_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("manual_add_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    select_position_list = Position.get_select_position_list(params[:current_process_id], params[:user_id], params[:sub_step])
    render :json => {
      :success => true,
      :positions => select_position_list,
    }
  end

  def manual_update_positions
    permission_to_show, permission_to_active, permission_message = check_user_permission("manual_add_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    begin
      user_id = params[:user_id]
      procedure_id = params[:current_process_id]
      success, msg, new_create_position_ids = Application.update_positions_select(user_id, procedure_id, params[:add_ids] || [], params[:delete_ids] || [])
      select_positions = Position.includes(:applications).where(:procedure_id => procedure_id, :applications => {:user_id => user_id}).pluck(:name).join(", ")
      render :json => {:success => success, :msg => msg, :select_positions => select_positions}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "Failed to select the position."}
    end
  end

end
