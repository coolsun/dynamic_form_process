class AddAcademicStandingsToPeoplesoftDetails < ActiveRecord::Migration
  def change
    add_column :peoplesoft_details, :academic_standings, :text
  end
end
