class FormInput < ActiveRecord::Base
  #peter hide for this model not to create version 20150316
  #has_paper_trail

  def self.question_filters_user_ids(all_question_filters, procedure_id)
    match_user_ids = []
    filter_match_users = []
    all_question_filters.each do |question_filter|
      if question_filter['form_type'] == 'System Forms'
        form_table = 'USER_FORMS'
        form_type  = 'System'
      elsif question_filter['form_type'] == 'Attachable Forms'
        form_table = 'USER_FORMS'
        form_type  = 'Application'
      elsif question_filter['form_type'] == 'Recommendations'
        form_table = 'RECOMMENDATION_FORMS'
        form_type  = 'Recommender'
      end
      filters = []

      if form_table == 'USER_FORMS'
        origin_form = Form.where(:procedure_id => procedure_id, :form_name => question_filter['form_name'], :form_type => form_type).first
        return [] unless origin_form
      else
        origin_form_filled_forms = RecommendationForm.includes(:recommendation_record).where(:recommendation_records => {:procedure_id => procedure_id}, :form_name => question_filter['form_name'])
        return [] unless origin_form_filled_forms
        origin_form_filled_form_ids = origin_form_filled_forms.pluck(:id)
      end

      filters << "form_inputs.form_table = \'#{form_table}\'"
      filters << "form_inputs.form_type = \'#{form_type}\'"
      filters << "form_inputs.form_name = \'#{question_filter['form_name']}\'"
      question = question_filter['question'].gsub("'", "''")  #oracle escape special characters
      filters << "to_char(form_inputs.schema_description) = \'#{question}\'"
      if /is null/.match(question_filter['question_attribute'])
        filters << "(length(form_inputs.schema_value) = 0 or form_inputs.schema_value is null)"
      elsif /not null/.match(question_filter['question_attribute'])
        filters << "length(form_inputs.schema_value) > 0"
      else
        filters << "to_char(form_inputs.schema_value) #{question_filter['question_attribute']} \'#{question_filter['question_attribute_value']}\'"
      end
      form_ids = self.where(filters.join(' and ')).pluck(:form_id)
      form_ids = form_ids.in_groups_of(1000, false)

logger.info "== form input's form ids ============="
logger.info form_ids.to_json
logger.info "======================================"

      #logger.info "== form_input #{form_input.as_json} =="
      if form_table == 'USER_FORMS'
        arr = []
        form_ids.each do |form_id_of_1000|
          arr += UserForm.where(:id => form_id_of_1000, :form_id => origin_form.id).pluck(:user_id)
        end
logger.info "== arr? =============================="
logger.info arr.to_json
logger.info "======================================"

        filter_match_users << arr
      elsif form_table == 'RECOMMENDATION_FORMS'
        arr = []
        form_ids.each do |form_id_of_1000|
          match_form_ids = form_id_of_1000 - (form_id_of_1000 - origin_form_filled_form_ids)
          arr += RecommendationForm.includes(:recommendation_record).where(:id => match_form_ids).collect{|r_form| r_form.recommendation_record.user_id}
        end
        filter_match_users << arr
      end
    end
logger.info "== filter_match_users ================"
logger.info filter_match_users.to_json
logger.info "======================================"

    match_user_ids = filter_match_users.first
    filter_match_users.each do |filter_match_user|
      match_user_ids = match_user_ids & filter_match_user
    end
logger.info "== match_user_ids ===================="
logger.info match_user_ids.to_json
logger.info "======================================"

    return match_user_ids
  end

end
