class RecommendationForm < ActiveRecord::Base
  has_paper_trail

  belongs_to :recommendation_record;
  belongs_to :user, :primary_key => "sunet_id", :foreign_key => "recommender_sunet_id"
  has_many :upload_files;

  def self.schema_add_name_relationship(form)
    schema = JSON.parse(form.schema)
    schema.insert(0, { "row" => 0, "column" => 0, "description" => "Recommender Name: " + form.recommendation_record.name, "type" => "description" })
    schema.insert(1, { "row" => 0, "column" => 0, "description" => "Relationship: " + form.recommendation_record.relationship, "type" => "description" })
    form.schema = schema.to_json
    return form
  end

end
