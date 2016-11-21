class RecommendationSettingsController < ApplicationController
  before_action :set_recommendation_setting, only: [:update]

  def get_setting
    permission_to_show, permission_to_active, permission_message = check_user_permission("recommendation")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    @recommendation_setting = RecommendationSetting.find_by_procedure_id(params[:procedure_id])
    render :json => {:success => true, :recommendation_setting => @recommendation_setting, :permission_to_active => permission_to_active}
  end

  # PATCH/PUT /recommendation_settings/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("recommendation")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    @recommendation_setting.update(recommendation_setting_params)
    if @recommendation_setting.errors.any?
      render :json => {:success => false, :msg => get_error_messages(@recommendation_setting)}
    elsif @recommendation_setting
      render :json => {:success => true, :msg => "The recommendation setting has been updated successfully.", :recommendation_setting => @recommendation_setting}
    else
      render :json => {:success => false, :msg => "There was a problem to update the recommendation setting."}
    end
  end

  private
    def set_recommendation_setting
      @recommendation_setting = RecommendationSetting.find_by_id(params[:id])
    end
    def recommendation_setting_params
      params.require(:recommendation_setting).permit(:number, :show_recommendation, :requirement, :no_need_recommendation)
    end
end
