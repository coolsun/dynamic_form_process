class AddTimestampToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :offered_at, :datetime
    add_column :applications, :offer_accept_at, :datetime
  end
end
