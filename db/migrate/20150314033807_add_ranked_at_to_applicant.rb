class AddRankedAtToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :ranked_at, :datetime
  end
end