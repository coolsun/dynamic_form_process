class RdMgrsController < ApplicationController

  def get_select_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process RD")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    rd_mgrs = []
    User.includes(:rd_mgrs, :user_procedures).references(:rd_mgrs, :user_procedures).where(:user_procedures => {:procedure_id => params[:current_process_id]}).each do |user|
      is_select = false
      user.rd_mgrs.each do |rd_mgr|
        is_select = true if rd_mgr.procedure_id == params[:procedure_id].to_i
      end
      rd_mgrs << {
        :user_id => user.id,
        :name => user.name,
        :is_select => is_select
      }
    end
    render :json => {:success => true, :rd_mgrs => rd_mgrs}
  end

  def update_rd_mgrs
    permission_to_show, permission_to_active, permission_message = check_user_permission("Process RD")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    begin
      procedure_id = params[:procedure_id].to_i
      if params[:add_ids].kind_of?(Array)
        db_user_ids = []
        RdMgr.where(:procedure_id => procedure_id).each do |rd_mgr|
          db_user_ids << rd_mgr.user_id
        end
        params[:add_ids].each do |user_id|
          RdMgr.create(:user_id => user_id, :procedure_id => procedure_id) if !db_user_ids.include?(user_id.to_i)
        end
      end

      if params[:delete_ids].kind_of?(Array)
        RdMgr.where(:user_id => params[:delete_ids], :procedure_id => procedure_id).destroy_all
      end
      procedure = Procedure.find_by_id(procedure_id).as_json({:include => [
        {:procedure_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}},
        {:rd_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}}],
       :only => [:id, :name, :status, :rank, :acronym]})
      render :json => {:success => true, :msg => "The RD managers have been updated successfully.", :procedure => procedure}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "There was a problem to update the RD managers."}
    end
  end
end
