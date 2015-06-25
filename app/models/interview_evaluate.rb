class InterviewEvaluate < ActiveRecord::Base
  has_paper_trail

  has_one :interview_evaluate_form, :dependent => :destroy;
  belongs_to :reviewer, class_name: "User", foreign_key: "judge_interviewer_user_id";
  belongs_to :form;
end
