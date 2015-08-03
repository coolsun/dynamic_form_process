class ProceduresController < ApplicationController

  # GET /procedures/1
  def show
    @procedure = Procedure.find_by_id(params[:id])

    if @procedure
      render :json => {:success => true, :procedure => @procedure}
    else
      render :json => {:success => false}
    end
  end

  # GET /procedures
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_ids = current_user.get_mgr_procedure_ids
    procedure_list, procedures_total = Procedure.get_procedure_list(rsas_table_params, procedure_ids)
    logger.info "== procedure_list #{procedure_list} =="

    procedure_list.each do |procedure|
      procedure[:permission] = {
        :edit_users => is_admin || is_hiring_mgr(procedure["id"]),
        :edit_rd_managers => is_admin || is_hiring_mgr(procedure["id"]),
        :edit_apply_white_lists => is_admin || is_hiring_mgr(procedure["id"]),
      }
    end

    render :json => {
      :now => params[:page],
      :total => procedures_total,
      :show => procedure_list,
      :success => true,
      :permission_to_active => permission_to_active
    }
  end

  # POST /procedures
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    @procedure = Procedure.create(create_procedure_params)
    if @procedure.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@procedure)}
    elsif @procedure.id && @procedure.create_new_procedure(params[:current_year_id])
      render :json => {:success => true, :msg => "The process has been created successfully.",  :procedure => @procedure.as_json(:include => [{:users => {:methods => [:name], :only => :name}}])}
    else
      render :json => {:success => false, :msg => "Failed to create the process."}
    end
  end

  # PATCH/PUT /procedures/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @procedure = Procedure.find_by_id(params[:id])
    if params[:procedure] && @procedure.update(update_procedure_params)
      render :json => {:success => false, :msg => get_error_messages(@procedure)} and return if @procedure.errors.any?

      application_step_id = ProcedureStep.where(:procedure_id => params[:id], :name => "Application").pluck(:id).first
      logger.info("== @procedure #{@procedure.as_json(:include => [:users])} ==")
      render :json => {:success => true, :msg => "The process has been updated successfully.", :process => @procedure.as_json(:include => [{:users => {:methods => [:name], :only => :name}}])}
    else
      render :json => {:success => false, :msg => "There was a problem to update the process."}
    end
  end

  # DELETE /procedures/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    @procedure = Procedure.find_by_id(params[:id])

    if @procedure.status
      render :json => {:success => false, :msg => "You can not delete this procss when its status is ''true''. Please go to ''Setting'' to turn the status to ''false'', and try to delete again."} and return
    end

    if @procedure.destroy
      render :json => {:success => true, :msg => "The process has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the process."}
    end
  end

  def clone_process
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @procedure = Procedure.create(create_procedure_params)
    if @procedure.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@procedure)}
    elsif @procedure.id && @procedure.clone_procedure(params[:clone_process_id])
      render :json => {:success => true, :msg => "The process has been cloned successfully."}
    else
      render :json => {:success => false, :msg => "Failed to clone the process."}
    end
  end

  def clone_all_process
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Clone")
    render :json => {:success => false, :clone_messages => [permission_message], :years => Year.year_list_for_clone} and return if !permission_to_active

    is_success, clone_messages = Procedure.clone_all_procedure(params[:source_year_id], params[:target_year_id])

    if is_success
      render :json => {:success => true, :msg => "All the processes have been cloned successfully.", :years => Year.year_list_for_clone}
    else
      render :json => {:success => false, :clone_messages => clone_messages, :years => Year.year_list_for_clone}
    end
  end

  def show_all_procedure
    year = current_year
    procedures = Procedure.where(:status => true, :year_id => year.id).order(:rank => :asc)

    procedure_list = []
    if params[:get_landing] == "true"
      procedures.each do |procedure|
        edit_procedure = procedure.as_json
        edit_procedure[:landing] = procedure.landing(year.id, current_user.try(:id))
        edit_procedure[:apply_message] = procedure.apply_message(current_user.try(:id))
        procedure_list << edit_procedure
      end
    else
      procedure_list = procedures
    end

    render :json => {
      :procedures => procedure_list,
      :year => year
    }
  end

  def check_recommendation_form_open
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    recommendation_form_open_number = Form.where(:procedure_id => params[:procedure_id], :form_type => "Recommender", :display => true).length
    application_step_id = ProcedureStep.where(:procedure_id => params[:procedure_id], :name => "Application").pluck(:id).first
    recommendation_sub_step_enabled = ProcedureSubStep.where(:procedure_step_id => application_step_id, :identify_name => "recommendation").pluck(:enabled).first

    save_button_disabled = (recommendation_form_open_number == 0) && recommendation_sub_step_enabled

    render :json => {:success => true, :save_button_disabled => save_button_disabled}
  end

  def get_locations_and_roles
    i_procedure_id = params[:current_process_id].to_i;

    locations = Location.where(:procedure_id => i_procedure_id);
    roles = Role.where(:procedure_id => i_procedure_id);


    render :json => {
      :locations => locations,
      :roles => roles
    }
  end

  def mgr_procedures_select
    procedure_ids = current_user.get_mgr_procedure_ids
    procedures = Procedure.where(:id => procedure_ids)

    render :json => {
      :success => true,
      :procedures => procedures
    }
  end

  private
    def create_procedure_params
      params.require(:procedure).permit(:name, :acronym, :year_id)
    end

    def update_procedure_params
      params.require(:procedure).permit(:name, :rank, :status, :contact_email, :domain, :faq_url)
    end

end
