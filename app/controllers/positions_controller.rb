class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = rsas_table_params.i_procedure_id

    permission_condistion = {
      :condistion => "",
      :role_ids => [],
      :location_ids => []
    }

    if is_admin || is_hiring_mgr(procedure_id)
    else
      permission_condistion = {
        :condistion => "role_id in (?) or location_id in (?)",
        :role_ids => current_user_role_mgr_role_ids_in_procedure(procedure_id),
        :location_ids => current_user_location_mgr_location_ids_in_procedure(procedure_id)
      }
    end

    position_list, positions_total = Position.get_position_list(rsas_table_params, permission_condistion)

    render :json => {
      :now => params[:page],
      :total => positions_total,
      :show => position_list,
      :success => true,
      :permission_to_active => permission_to_active
    }
  end

  # POST /positions
  def create
    position = Position.new(position_params)
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions", {:position => position})
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    position.save
    if position.errors.any?
      render :json => {:success => false, :msg => get_error_messages(position)}
    elsif position
      render :json => {:success => true, :msg => "The position has been created successfully."}
    else
      render :json => {:success => false, :msg => "Failed to create the position."}
    end
  end

  # PATCH/PUT /positions/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions", {:position => @position})
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @position.update(position_params)
    if @position.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@position)}
    elsif @position
      render :json => {:success => true, :msg => "The position has been updated successfully.", :position => @position.as_json(:include => [:role, :location])}
    else
      render :json => {:success => false, :msg => "Failed to update the position."}
    end
  end

  # DELETE /positions/1
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions", {:position => @position})
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @position.destroy
    if @position.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@position)}
    elsif @position.destroy
      render :json => {:success => true, :msg => "The position has been deleted successfully."}
    else
      render :json => {:success => false, :msg => "Failed to delete the position."}
    end
  end

  def get_select_lists
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id]
    locations = Location.select(:id, :name).where(:procedure_id => procedure_id).order(:name)
    roles = Role.select(:id, :name).where(:procedure_id => procedure_id).order(:name)
    render :json => {:success => true, :locations => locations, :roles => roles}
  end

  def invitation_create_position
    position = Position.new(position_params)
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_positions", {:position => position})
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    position.save
    if position.errors.any?
      render :json => {:success => false, :msg => get_error_messages(position)}
    elsif position
      applicants = Procedure.find_by_id(position.procedure_id).no_offered_applicants
      position = {
        :id => position.id,
        :name => position.name,
        :tag => position.tag,
        :vacancy => position.vacancy,
        :applicants => applicants.sort! { |a, b| a[:name].downcase <=> b[:name].downcase },
        :description => position.description,
        :auto_matching => position.auto_matching,
        :one_year_up => position.one_year_up
      }
      render :json => {:success => true, :msg => "The position has been created successfully.", :position => position}
    else
      render :json => {:success => false, :msg => "Failed to create the position."}
    end
  end

  private
    def set_position
      @position = Position.find_by_id(params[:id])
    end
    def position_params
      params.require(:position).permit(:role_id, :procedure_id, :location_id, :vacancy, :tag, :auto_matching, :one_year_up, :description, :offer_appointment)
    end
end
