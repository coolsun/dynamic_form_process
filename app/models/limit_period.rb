class LimitPeriod < ActiveRecord::Base
  belongs_to :procedure
  has_many :limit_managers, :dependent => :destroy

  def roles
    roles = []
    self.limit_managers.where.not(:role_id => nil).each do |limit_manager|
      roles << limit_manager.role.as_json(:only => [:id, :name]) if limit_manager.role
    end
    return roles
  end

  def locations
    locations = []
    self.limit_managers.where.not(:location_id => nil).each do |limit_manager|
      locations << limit_manager.location.as_json(:only => [:id, :name]) if limit_manager.location
    end
    return locations
  end

  def t_start_string
    return self.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M")
  end

  def t_end_string
    return self.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M")
  end

end