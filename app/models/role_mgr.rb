class RoleMgr < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :role;

  validates_uniqueness_of :user_id, :scope => :role_id, :message => "This Role Mgr already exists."
end
