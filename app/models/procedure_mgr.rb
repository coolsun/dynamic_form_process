class ProcedureMgr < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :procedure;

end
