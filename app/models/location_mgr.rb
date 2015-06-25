class LocationMgr < ActiveRecord::Base
  has_paper_trail

  belongs_to :location
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :location_id, :message => "This Location Mgr already exists."
end
