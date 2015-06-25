class ProcedureMgrsController < ApplicationController

  def get_select_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_mgrs = []
    User.includes(:procedure_mgrs, :user_procedures).references(:procedure_mgrs, :user_procedures).where(:user_procedures => {:procedure_id => params[:current_process_id]}, :status => "Staff").each do |user|
      is_select = false
      user.procedure_mgrs.each do |procedure_mgr|
        is_select = true if procedure_mgr.procedure_id == params[:procedure_id].to_i
      end
      procedure_mgrs << {
        :user_id => user.id,
        :name => user.name,
        :is_select => is_select
      }
    end
    render :json => {:success => true, :procedure_mgrs => procedure_mgrs}
  end

  def update_procedure_mgrs
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    begin
      procedure_id = params[:procedure_id].to_i
      if params[:add_ids].kind_of?(Array)
        db_user_ids = []
        ProcedureMgr.where(:procedure_id => procedure_id).each do |procedure_mgr|
          db_user_ids << procedure_mgr.user_id
        end
        params[:add_ids].each do |user_id|
          ProcedureMgr.create(:user_id => user_id, :procedure_id => procedure_id) if !db_user_ids.include?(user_id.to_i)
        end
      end

      if params[:delete_ids].kind_of?(Array)
        ProcedureMgr.where(:user_id => params[:delete_ids], :procedure_id => procedure_id).destroy_all

        delete_user_ids = params[:delete_ids];
        delete_user_ids.each do |user_id|
          i_procedure_id = params[:current_process_id].to_i;
          i_user_id = user_id.to_i;
          Interviewer.check_managers_interviewer(i_user_id, i_procedure_id);
        end
      end
      procedure = Procedure.find_by_id(procedure_id).as_json({:include => [
        {:procedure_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}},
        {:rd_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}}],
       :only => [:id, :name, :status, :rank, :acronym]})
      render :json => {:success => true, :msg => "The hiring managers have been updated successfully.", :procedure => procedure}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "Failed to update the hiring managers."}
    end
  end
end
