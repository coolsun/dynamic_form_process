class AddMgrRankedAtMgrRankUserIdToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :mgr_ranked_at, :datetime
    add_column :applications, :mgr_ranked_user_id, :integer
  end
end