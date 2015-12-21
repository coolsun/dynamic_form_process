class RecommendationRecord < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :procedure;
  has_one :recommendation_form;
  belongs_to :form_template, :class_name => "Form", :foreign_key => :recommendation_form_id;

  def created_at_string
    self.created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M %p")
  end

  def submit_date_string
    self.submit_date ? self.submit_date.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M %p") : ""
  end
end
