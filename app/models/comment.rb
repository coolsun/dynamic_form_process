class Comment < ActiveRecord::Base
  belongs_to :applicant
  has_many :comment_in_locations
end
