class ProcedureHelpLandingsController < ApplicationController

  def index
    all_help_landings = ProcedureHelpLanding.where(:procedure_id => params[:procedure_id])

    permission_to_show, permission_to_active, permission_message = check_user_permission("help landing")
    render :json => { :success => true, :all_help_landings => all_help_landings, :permission => permission_to_active }
  end
  
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("help landing")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    ProcedureHelpLanding.create(
      :doings => params[:new_help][:doings],
      :department => params[:new_help][:department],
      :contact => params[:new_help][:contact],
      :procedure_id => params[:procedure_id]
    )    
    all_help_landings = ProcedureHelpLanding.where(:procedure_id => params[:procedure_id])

    render :json => { :success => true, :all_help_landings => all_help_landings }
  end
  
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("help landing")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    update_help_landing = ProcedureHelpLanding.where(:id => params[:id]).first
    update_help_landing.update_attributes(
      :doings => params[:old_help][:doings],
      :department => params[:old_help][:department],
      :contact => params[:old_help][:contact]
    )

    render :json => { :success => true, :updated_help_landing => update_help_landing }
  end
  
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("help landing")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    delete_help_landing = ProcedureHelpLanding.where(:id => params[:id]).first
    delete_help_landing.destroy
    all_help_landings = ProcedureHelpLanding.where(:procedure_id => params[:procedure_id])

    render :json => { :success => true, :all_help_landings => all_help_landings }
  end

end