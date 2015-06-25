class ReportsController < ApplicationController

  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    if is_admin
      procedures = Procedure.where(:year_id => params[:current_year_id])
    else
      procedure_ids = current_user.procedure_mgrs.pluck(:procedure_id)
      procedures = Procedure.where(:year_id => params[:current_year_id], :id => procedure_ids)
    end

    render :json => {
      :success => true,
      :permission_to_show => permission_to_show,
      :procedures => procedures
    }
  end

  def applicant_list_report
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    @procedure = Procedure.find_by_id(params[:procedure_id])
    @applicants = Applicant.joins(:user).where(:procedure_id => @procedure.id).order("users.first_name asc")

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='applicant_list_report_#{Time.now.pst_s('%Y_%m_%d_%H_%M')}.xlsx'"
      }
    end
  end

  def academic_record_report
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    @procedure = Procedure.find_by_id(params[:procedure_id])
    @applicants = Applicant.joins(:user).where(:procedure_id => @procedure.id).order("users.first_name asc")

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='academic_record_report_#{Time.now.pst_s('%Y_%m_%d_%H_%M')}.xlsx'"
      }
    end
  end

  def ranking_report
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    procedure = Procedure.find_by_id(params[:procedure_id])
    applicants = Applicant.joins(:user).where(:procedure_id => procedure.id).order("users.first_name asc")

    @title_row = ["Full Name", "Preferred Name", "SUNet ID", "SUID", "Status", "Ranked", "Time stamp of ranking"]
    @data_types = [nil, nil, nil, :string] #for SUID not to number
    @applicant_datas = []
    max_length = 0

    applicants.each do |applicant|
      user = applicant.user

      applicant_data = [
        user.name,
        applicant.preferred_name,
        user.sunet_id,
        user.suid,
        applicant.status,
        applicant.ranked_at.present?,
        (applicant.ranked_at ? applicant.ranked_at.pst_s : nil),
        applicant.ranking_position_names
      ].flatten

      max_length = applicant_data.length if applicant_data.length > max_length

      @applicant_datas << applicant_data
    end

    (max_length - @title_row.length).times do | i |
      count = i + 1
      @title_row << "Position #{count}"
    end

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='ranking_report_#{Time.now.pst_s('%Y_%m_%d_%H_%M')}.xlsx'"
      }
    end
  end

  def offered_unoffered_report
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    @procedure = Procedure.find_by_id(params[:procedure_id])
    @applicants = Applicant.joins(:user).where(:procedure_id => @procedure.id).order("users.first_name asc")

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='offered_unoffered_report_#{Time.now.pst_s('%Y_%m_%d_%H_%M')}.xlsx'"
      }
    end
  end

  def manager_ranking_report
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    @procedure = Procedure.find_by_id(params[:procedure_id])
    @applications = Application.joins(:position => :location)
                               .where(:disable_user_rank => nil, :disable_mgr_rank => nil, :positions => {:procedure_id => @procedure.id})
                               .where.not(:mgr_ranked_at => nil)
                               .order("locations.name asc")

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='manager_ranking_report_#{Time.now.pst_s('%Y_%m_%d_%H_%M')}.xlsx'"
      }
    end
  end

end
