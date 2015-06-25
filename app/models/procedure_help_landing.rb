class ProcedureHelpLanding < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure
end