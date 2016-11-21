class AddNoNeedRecommendationColumn < ActiveRecord::Migration
  def change
    add_column :recommendation_settings, :no_need_recommendation, :boolean, default: false
  end
end
