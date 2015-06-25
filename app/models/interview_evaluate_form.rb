class InterviewEvaluateForm < ActiveRecord::Base
  has_paper_trail

  belongs_to :interview_evaluate;
  has_many :upload_files;

  def form_name
    return self.interview_evaluate.form.form_name
  end

end
