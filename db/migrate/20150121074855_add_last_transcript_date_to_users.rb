class AddLastTranscriptDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_transcript_date, :date
  end
end
