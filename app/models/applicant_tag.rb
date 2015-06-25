class ApplicantTag < ActiveRecord::Base
  has_paper_trail

  belongs_to :applicant

end
