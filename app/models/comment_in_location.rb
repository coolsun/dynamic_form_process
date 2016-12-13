class CommentInLocation < ActiveRecord::Base
  belongs_to :comment
  belongs_to :location
end
