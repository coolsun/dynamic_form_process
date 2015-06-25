class YearsController < ApplicationController
  before_action :set_year, only: [:update, :destroy]

  # GET /years
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = rsas_table_params.i_procedure_id

    year_list, years_total = Year.get_year_list(rsas_table_params)

    render :json => {
      :now => params[:page],
      :total => years_total,
      :show => year_list,
      :success => true,
      :permission_to_active => permission_to_active
    }
  end

  # POST /years
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    year = Year.create(year_params)
    if year.errors.any?
      render :json => {:success => false, :msg => get_error_messages(year)}
    else
      if Year.clone_admins(current_year.id, year.id)
        render :json => {:success => true, :msg => "The year has been created successfully.", :year => year}
      else
        year.destroy
        render :json => {:success => false, :msg => "Failed to create the year."}
      end
    end
  end

  # PATCH/PUT /years/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @year.update(year_params)
    if @year.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@year)}
    elsif @year
      render :json => {:success => true, :msg => "The year has been updated successfully.", :year => @year}
    else
      render :json => {:success => false, :msg => "There was a problem to update the year."}
    end
  end

  # DELETE /years/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @year.destroy
    if @year.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@year)}
    elsif @year
      render :json => {:success => true, :msg => "The year has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the year."}
    end
  end

  def get_year_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Clone")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    years = Year.year_list_for_clone
    render :json => {:success => true, :years => years, :permission_to_active => permission_to_active}
  end

  def set_current_year
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    Year.update_all(:is_current_year => false)
    year = Year.update(params[:id], :is_current_year => true)
    if year.errors.any?
      render :json => {:success => false, :msg => get_error_messages(year)}
    elsif year
      render :json => {:success => true, :msg => "The current year has been set successfully."}
    else
      render :json => {:success => false, :msg => "Failed to set the current year."}
    end
  end

  def admin_switch_year
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    year = Year.find_by_id(params[:id])
    if year
      procedures = Procedure.where(:year_id => year.id)
      procedure = procedures.first || {id: 0, name: "No process", acronym: "NOPROCESS"}

      render :json => {:success => true, :msg => "The year has been switched successfully.", :current_year => year, :current_process => procedure, :processes => procedures}
    else
      render :json => {:success => false, :msg => "The year does not exist."}
    end
  end

  def check_url_year_and_procedure
    is_success = false
    return_url = "/saas/index.html"

    if params[:get_return_url]
      return_url = transform_return_url(session[:return_url])
      session[:return_url] = nil
    else
      system_year = current_year

      if params[:get_default_year_and_procedure]
        year = system_year
        procedure = Procedure.where(:year_id => year.try(:id)).first || {id: 0, name: "No process", acronym: "NOPROCESS"}
      else
        year = Year.find_by_name(params[:year])
        procedure = Procedure.where(:acronym => params[:procedure], :year_id => year.try(:id)).first
      end

      if procedure
        if system_year.id == year.try(:id)
          is_success = true
        elsif system_year.id != year.try(:id) && is_admin
          is_success = true
        end
      end
    end

    if is_success
      render :json => {:success => true, :year => year, :procedure => procedure}
    else
      render :json => {:success => false, :return_url => return_url}
    end
  end

  def set_return_url
    session[:return_url] = params[:return_url]
    return_url = transform_return_url(session[:return_url])
    logger.info "==#{action_name}== session[:return_url]= #{session[:return_url]}== return_url = #{return_url}=="
    render :json => {
      :success => true,
      :return_url => return_url
    }
  end

  def transform_return_url(return_url)
    if return_url.blank?
      return_url = "/saas/index.html"
    elsif current_user.present? && return_url == "/saas/app/index.html#/process"
      if is_admin
        #don't change return_url
      elsif current_user.roles.first || current_user.locations.first
        #lm, rm change to select process
        return_url = "/saas/app/index.html#/process_select"
      end
    end

    return return_url
  end


  private
    def set_year
      @year = Year.find_by_id(params[:id])
    end
    def year_params
      params.require(:year).permit(:name, :next_year)
    end
end
