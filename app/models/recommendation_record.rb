class RecommendationRecord < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :procedure;
  has_one :recommendation_form;
  belongs_to :form_template, :class_name => "Form", :foreign_key => :recommendation_form_id;
end
