class ProcessFaqAndDomain < ActiveRecord::Migration
  def change
    add_column :procedures, :domain, :string
    add_column :procedures, :faq_url, :string
  end
end
