class LimitPeriodsController < ApplicationController

  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("lower_mgr_see_time")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    new_limit = LimitPeriod.create(
      :procedure_id => params[:current_process_id],
      :t_start => params[:limit][:t_start].blank? ? nil : Time.strptime(params[:limit][:t_start] + " PST", "%m/%d/%Y %I:%M %p %Z"),
      :t_end => params[:limit][:t_end].blank? ? nil : Time.strptime(params[:limit][:t_end] + " PST", "%m/%d/%Y %I:%M %p %Z")
    )

    params[:limit][:roles].each do |role|
      LimitManager.create(:limit_period_id => new_limit.id, :role_id => role[:id])
    end if params[:limit][:roles].kind_of?(Array)
    params[:limit][:locations].each do |location|
      LimitManager.create(:limit_period_id => new_limit.id, :location_id => location[:id])
    end if params[:limit][:locations].kind_of?(Array)

    all_limits = all_limits_in_process(params[:current_process_id])

    render :json => {:success => true, :all_limits => all_limits}
  end

  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("lower_mgr_see_time")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    limit = JSON.parse(params[:limit])

    update_limit = LimitPeriod.find_by_id(params[:id])
    update_limit.update_attributes(
      :t_start => limit["t_start_string"].blank? ? nil : Time.strptime(limit["t_start_string"] + " PST", "%m/%d/%Y %I:%M %p %Z"),
      :t_end => limit["t_end_string"].blank? ? nil : Time.strptime(limit["t_end_string"] + " PST", "%m/%d/%Y %I:%M %p %Z")
    )

    update_limit_mgrs = LimitManager.where(:limit_period_id => params[:id])
    update_limit_mgrs.destroy_all

    limit["roles"].each do |role|
      LimitManager.create(:limit_period_id => params[:id], :role_id => role["id"])
    end if limit["roles"].kind_of?(Array)
    limit["locations"].each do |location|
      LimitManager.create(:limit_period_id => params[:id], :location_id => location["id"])
    end if limit["locations"].kind_of?(Array)

    all_limits = all_limits_in_process(params[:current_process_id])

    render :json => {:success => true, :all_limits => all_limits}
  end

  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("lower_mgr_see_time")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    delete_limit = LimitPeriod.find_by_id(params[:id])
    delete_limit.destroy

    all_limits = all_limits_in_process(params[:current_process_id])

    render :json => {:success => true, :all_limits => all_limits}
  end

  def all_limits_in_process(process_id)
    all_limits = LimitPeriod.where(:procedure_id => process_id).order(:t_start => :asc)
                            .as_json(:methods => [:t_start_string, :roles, :locations, :t_end_string],
                                     :only => [:id, :t_start_string, :roles, :locations, :t_end_string])
  end

end