class LimitManager < ActiveRecord::Base
  belongs_to :limit_period
  belongs_to :role
  belongs_to :location
end