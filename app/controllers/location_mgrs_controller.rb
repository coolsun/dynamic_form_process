class LocationMgrsController < ApplicationController

  def get_select_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    location_mgrs = []
    User.includes(:location_mgrs, :user_procedures).references(:location_mgrs, :user_procedures).where(:user_procedures => {:procedure_id => params[:current_process_id]}).each do |user|
      is_select = false
      user.location_mgrs.each do |location_mgr|
        is_select = true if location_mgr.location_id == params[:location_id].to_i
      end
      location_mgrs << {
        :user_id => user.id,
        :name => user.name,
        :is_select => is_select
      }
    end
    render :json => {:success => true, :location_mgrs => location_mgrs}
  end

  def update_location_mgrs
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    location_id = params[:location_id].to_i
    location_ids = current_user_location_mgr_location_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!location_id.in?(location_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    begin
      if params[:add_ids].kind_of?(Array)
        db_user_ids = []
        LocationMgr.where(:location_id => location_id).each do |location_mgr|
          db_user_ids << location_mgr.user_id
        end
        params[:add_ids].each do |user_id|
          LocationMgr.create(:user_id => user_id, :location_id => location_id) if !db_user_ids.include?(user_id.to_i)
        end
      end

      if params[:delete_ids].kind_of?(Array)
        LocationMgr.where(:user_id => params[:delete_ids], :location_id => location_id).destroy_all

        delete_user_ids = params[:delete_ids];
        delete_user_ids.each do |user_id|
          i_procedure_id = params[:current_process_id].to_i;
          i_user_id = user_id.to_i;
          Interviewer.check_managers_interviewer(i_user_id, i_procedure_id);
        end
      end
      location = Location.find_by_id(location_id).as_json(:include => [{:location_mgrs => {:include => :user}}])
      render :json => {:success => true, :msg => "The location managers have been updated successfully.", :location => location}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "There was a problem to update the location managers."}
    end
  end
end
