class FormTag < ActiveRecord::Base
  has_paper_trail

  belongs_to :form
  
end
