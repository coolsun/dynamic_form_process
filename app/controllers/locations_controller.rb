class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Create Location")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = rsas_table_params.i_procedure_id

    location_ids_condition = {}
    if is_admin || is_hiring_mgr(procedure_id)
    else
      location_ids_condition = {:id => current_user_location_mgr_location_ids_in_procedure(procedure_id)}
    end

    location_list, locations_total = Location.get_location_list(rsas_table_params, location_ids_condition)

    render :json => {
      :now => params[:page],
      :total => locations_total,
      :show => location_list,
      :success => true,
      :permission_to_active => permission_to_active
    }
  end

  # POST /locations
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Create Location")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    location = Location.create(location_params)
    if location.errors.any?
      render :json => {:success => false, :msg => get_error_messages(location)}
    elsif location
      render :json => {:success => true, :msg => "The location has been created successfully.", :location => location}
    else
      render :json => {:success => false, :msg => "Failed to create the location."}
    end
  end

  # PATCH/PUT /locations/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    location_ids = current_user_location_mgr_location_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!@location.id.in?(location_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    @location.update(location_params)
    if @location.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@location)}
    elsif @location
      render :json => {:success => true, :msg => "The location has been updated successfully.", :location => @location}
    else
      render :json => {:success => false, :msg => "Failed to update the location."}
    end
  end

  # DELETE /locations/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    location_ids = current_user_location_mgr_location_ids
    render :json => {:success => false, :msg => "Insufficient privileges"} and return if (!@location.id.in?(location_ids) and !is_admin and !is_hiring_mgr(params[:current_process_id]))

    @location.destroy
    if @location.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@location)}
    elsif @location
      render :json => {:success => true, :msg => "The location has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the location."}
    end
  end

  private
    def set_location
      @location = Location.find_by_id(params[:id])
    end
    def location_params
      params.require(:location).permit(:procedure_id, :name, :tag, :description, :is_row_house)
    end
end
