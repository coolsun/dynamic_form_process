class UploadFile < ActiveRecord::Base
  has_paper_trail

  acts_as_paranoid

  belongs_to :user_form;
  belongs_to :recommendation_form;
  belongs_to :interview_evaluate_form;

end
