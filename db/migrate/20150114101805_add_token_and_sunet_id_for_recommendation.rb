class AddTokenAndSunetIdForRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendation_records, :token, :string
    add_column :recommendation_forms, :recommender_sunet_id, :string
  end
end
