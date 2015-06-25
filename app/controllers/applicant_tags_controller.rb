class ApplicantTagsController < ApplicationController

  def get_applicant_tags
    permission_to_show, permission_to_active, permission_message = check_user_permission("applicant_tags")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    tags = ApplicantTag.joins(:applicant).where(:applicants => {:user_id => params[:user_id], :procedure_id => params[:current_process_id]})
    render :json => {:success => true, :tags => tags.as_json(:only => [:id, :name])}
  end

  def update_applicant_tags
    permission_to_show, permission_to_active, permission_message = check_user_permission("applicant_tags")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    applicant = Applicant.where(:user_id => params[:user_id], :procedure_id => params[:current_process_id]).first
    tags = ApplicantTag.where(:applicant_id => applicant.id)

    if params[:tags]
      delete_ids = tags.pluck(:id) - params[:tags].collect{|obj| obj["id"].to_i} - [0]
      ApplicantTag.delete_all(:id => delete_ids) if delete_ids.present?

      params[:tags].each do |tag|
        ApplicantTag.create(:name => tag[:name], :applicant_id => applicant.id) if !tag[:id]
      end

    else
      tags.delete_all
    end
    render :json => {:success => true, :msg => "The applicant tags have been updated successfully."}
  end
end





