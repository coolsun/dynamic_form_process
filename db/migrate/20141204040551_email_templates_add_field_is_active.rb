class EmailTemplatesAddFieldIsActive < ActiveRecord::Migration
  def change
    add_column :email_templates, :is_active, :boolean
  end
end
