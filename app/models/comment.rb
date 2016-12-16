class Comment < ActiveRecord::Base
  has_paper_trail

  belongs_to :applicant
  has_many :comment_in_locations
end
