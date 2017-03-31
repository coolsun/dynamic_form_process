class MatchingController < ApplicationController

  def get_match_data
    permission_to_show, permission_to_active, permission_message = check_user_permission("match")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure_id = params[:current_process_id]
    render :json => {
      :success => true,
      :match_data => Matching.data(procedure_id),
      #:locations => Location.get_locations_with_applicant_tags(procedure_id),
      :permission_to_active => permission_to_active
    }
  end

  def match
    permission_to_show, permission_to_active, permission_message = check_user_permission("match")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active


    procedure_id = params[:current_process_id]

    Application.joins(:position).where(:auto_match => true,:positions => {:procedure_id => procedure_id}).update_all(:auto_match => false)

    result = Matching.run_match(procedure_id, params[:match_conditions])

    logger.info(result);

    render :json => {:success => result[:success], :match_data => Matching.data(procedure_id), :msg => result[:msg]}

  end
end
