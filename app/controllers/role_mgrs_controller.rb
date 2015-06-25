class RoleMgrsController < ApplicationController

  def get_select_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    role_mgrs = []
    User.includes(:role_mgrs, :user_procedures).references(:role_mgrs, :user_procedures).where(:user_procedures => {:procedure_id => params[:current_process_id]}).each do |user|
      is_select = false
      user.role_mgrs.each do |role_mgr|
        is_select = true if role_mgr.role_id == params[:role_id].to_i
      end
      role_mgrs << {
        :user_id => user.id,
        :name => user.name,
        :is_select => is_select
      }
    end
    render :json => {:success => true, :role_mgrs => role_mgrs}
  end

  def update_role_mgrs
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    role_id = params[:role_id].to_i
    role_ids = current_user_role_mgr_role_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!role_id.in?(role_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    begin
      if params[:add_ids].kind_of?(Array)
        db_user_ids = []
        RoleMgr.where(:role_id => role_id).each do |role_mgr|
          db_user_ids << role_mgr.user_id
        end
        params[:add_ids].each do |user_id|
          RoleMgr.create(:user_id => user_id, :role_id => role_id) if !db_user_ids.include?(user_id.to_i)
        end
      end

      if params[:delete_ids].kind_of?(Array)
        RoleMgr.where(:user_id => params[:delete_ids], :role_id => role_id).destroy_all

        delete_user_ids = params[:delete_ids];
        delete_user_ids.each do |user_id|
          i_procedure_id = params[:current_process_id].to_i;
          i_user_id = user_id.to_i;
          Interviewer.check_managers_interviewer(i_user_id, i_procedure_id);
        end
      end
      role = Role.find_by_id(role_id).as_json(:include => [{:role_mgrs => {:include => :user}}])
      render :json => {:success => true, :msg => "The role managers have been updated successfully.", :role => role}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "There was a problem to update the role managers."}
    end
  end
end
