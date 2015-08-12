class Form < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure;
  has_one :form_template, :class_name => "RecommendationRecord";
  has_many :form_tags, :dependent => :destroy;
  has_many :user_forms, :dependent => :destroy;

  def self.get_form_list(procedure_id, identify_name)
    procedure_id = procedure_id.present? ? procedure_id.to_i : nil
    forms = nil
    if procedure_id == 0
      forms = Form.where(:procedure_id => procedure_id)
    elsif
      forms = Form.where(:procedure_id => procedure_id,
                         :form_type => Form.get_form_type(identify_name)).as_json(:include => {:form_tags => {:only => [:role_id, :location_id, :position_id]}})
    end

    return forms
  end

  def self.get_form_type(sub_step_identify_name)
    form_type_hash = {
      "set_up_system_forms" => "System",
      "set_up_recommendation_forms" => "Recommender",
      "set_up_attachable_forms" => "Application",
      "set_up_interview_forms" => "Interview",
      "post_offer_fill_in_form" => "Application",
    }
    return form_type_hash[sub_step_identify_name]
  end

  def self.get_attachable_forms(procedure_id, user_id)
    applicant_select_position_ids = Application.where({:user_id => user_id}).collect{|applicant| applicant.position_id}
    applicant_select_location_ids = Position.where(:id => applicant_select_position_ids).pluck(:location_id)
    applicant_select_roles_ids    = Position.where(:id => applicant_select_position_ids).pluck(:role_id)
    application_forms = []
    Form.where({:procedure_id => procedure_id, :display => true, :form_type => "Application", :display => true}).order("rank").each do |form|
      form_tags = FormTag.where(:form_id => form.id)
      form_match_position_ids = form_tags.select { |form_tag| form_tag.position_id }.collect { |form_tag| form_tag.position_id }
      form_match_location_ids = form_tags.select { |form_tag| form_tag.location_id }.collect { |form_tag| form_tag.location_id }
      form_match_role_ids     = form_tags.select { |form_tag| form_tag.role_id     }.collect { |form_tag| form_tag.role_id }
      if (form_match_position_ids + form_match_location_ids + form_match_role_ids).blank?
        application_forms << form
      elsif (applicant_select_position_ids - form_match_position_ids).length < applicant_select_position_ids.length
        application_forms << form
      elsif (applicant_select_location_ids - form_match_location_ids).length < applicant_select_location_ids.length
        application_forms << form
      elsif (applicant_select_roles_ids - form_match_role_ids).length < applicant_select_roles_ids.length
        application_forms << form
      end
    end
    return application_forms
  end

  def self.translate_form_schema(schema, form_id, form_table, form_type, form_name)
    JSON.parse(schema).each do |column|
      form_input = FormInput.new
      form_input.form_id = form_id
      form_input.form_table = form_table
      form_input.form_type = form_type
      form_input.form_name = form_name
      form_input.schema_row = column["row"]
      form_input.schema_column = column["column"]
      form_input.schema_type = column["type"]
      form_input.schema_description = column["description"]
      form_input.schema_options = column["options"].select{|option| option != "\u003cbr /\u003e"}.join("|") if column["options"]
      form_input.schema_ps = column["ps"] ? (column["ps"] == "0" ? false : true) : false
      form_input.schema_rq = column["rq"] ? (column["rq"] == "0" ? false : true) : false
      if column["type"] == "name"
        form_input.schema_value = column["option"].collect{ |option| option["value"]}.join("|")
      elsif ["select", "radio"].include?(column["type"])
        form_input.schema_value = column["select"]
      elsif ["multi-select", "checkbox"].include?(column["type"])
        form_input.schema_value = column["select"].join("|") if column["select"]
      elsif column["type"] == "date"
        form_input.schema_value = Time.new(column["option"][2]["value"], column["option"][0]["value"], column["option"][1]["value"], 0, 0, 0, "-08:00").to_s
      elsif column["type"] == "file"
        if form_type == "Recommender"
          uploadfiles = UploadFile.where(:recommendation_form_id => form_id).pluck(:file_path)
        elsif form_type == "Interview"
          uploadfiles = UploadFile.where(:interview_evaluate_form_id => form_id).pluck(:file_path)
        else
          uploadfiles = UploadFile.where(:user_form_id => form_id).pluck(:file_path)
        end
        form_input.schema_value = uploadfiles.join("|") if uploadfiles.present?
      else
        form_input.schema_value = column["value"]
      end
      form_input.save!
    end
    return
  end

  def self.data_binding(schema, user_id, look_man_id)
    sql_user = User.find_by_id(user_id)
    if sql_user
      user = sql_user.as_json(:methods => [:address, :phone, :academics_status, :academics_type, :academics_plan, :academics_career, :academics_term])
      user["academics_gpa"] = sql_user.academics_gpa(look_man_id)
      user["academic_standing"] = sql_user.academic_standing(look_man_id)
    end

    new_schema = JSON.parse(schema)
    new_schema.each do |column|
      if sql_user && column["ps"]
        form_translation = FormTranslation.find_by_translate_key(column["description"])
        if form_translation
          column["value"] = user[form_translation.match_column]
          column["description"] = form_translation.description
          column["ps"] = true
        end
      elsif column["type"] == "date" && !column["option"]
        column["type"] = "date"
        column["option"] = [{"key" => "MM", "value" => ""}, {"key" => "DD", "value" => ""}, {"key" => "YYYY", "value" => ""}]
      elsif column["type"] == "name" && !column["option"]
        column["option"] = [{"key" => "First Name", "value" => ""}, {"key" => "Middle Name", "value" => ""}, {"key" => "Last Name", "value" => ""}]
      elsif column["type"] == "textarea"
        column["maxlength"] = column["maxlength"] ? column["maxlength"] : 1000
      end
      #logger.info "= #{column} ="
      if column["description"] == "Preferred Name (optional)"
        sql_user.update!(preferred_name: column["value"])
      end
    end
    new_schema = new_schema.to_json

    return new_schema
  end

  def position_ids
    position_ids = []
    form_tags = FormTag.where(:form_id => self.id)
    form_match_position_ids = form_tags.select { |form_tag| form_tag.position_id }.collect { |form_tag| form_tag.position_id }
    form_match_location_ids = form_tags.select { |form_tag| form_tag.location_id }.collect { |form_tag| form_tag.location_id }
    form_match_role_ids     = form_tags.select { |form_tag| form_tag.role_id     }.collect { |form_tag| form_tag.role_id }
    if (form_match_position_ids + form_match_location_ids + form_match_role_ids).blank?
      position_ids = Position.where(:procedure_id => self.procedure_id).pluck(:id)
    else
      position_ids = position_ids + Position.where(:location_id => form_match_location_ids).pluck(:id)
      position_ids = position_ids + Position.where(:role_id => form_match_role_ids).pluck(:id)
      position_ids = position_ids + Position.where(:id => form_match_position_ids).pluck(:id)
      position_ids = position_ids.uniq
    end
    return position_ids
  end

  def questions
    return JSON.parse(self.schema).select{|item| item["type"] != 'description'}.collect{|item| item["description"]}
  end

end
