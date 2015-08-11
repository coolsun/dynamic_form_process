class Procedure < ActiveRecord::Base
  has_paper_trail

  belongs_to :year
  has_one :recommendation_setting, :dependent => :destroy
  has_many :procedure_landings, :dependent => :destroy
  has_many :procedure_help_landings, :dependent => :destroy
  has_many :procedure_steps, :dependent => :destroy
  has_many :procedure_sub_steps, :through => :procedure_steps
  has_many :procedure_mgrs, :dependent => :destroy
  has_many :rd_mgrs, :dependent => :destroy
  has_many :users, :through => :procedure_mgrs;
  has_many :locations, :dependent => :destroy
  has_many :positions, :dependent => :destroy
  has_many :roles, :dependent => :destroy
  has_many :recommendation_records, :dependent => :destroy
  has_many :applicants, :dependent => :destroy
  has_many :rounds, :dependent => :destroy
  has_many :forms, :dependent => :destroy
  has_many :user_procedures, :dependent => :destroy
  has_many :system_messages, :dependent => :destroy
  has_many :limit_periods, :dependent => :destroy
  has_many :apply_white_lists, :dependent => :destroy

  validates_presence_of :acronym, :message=> "The acronym is required."
  validates_presence_of :acronym, :message=> "The name is required."
  validates_format_of :acronym, :with => /^[0-9A-Z]*$/, :multiline => true, :message=> "The acronym can only contain capitals A-Z and the number 0-9."
  validates_uniqueness_of :year_id, :scope => :acronym, :message=> "This acronym already exists."
  validates_uniqueness_of :year_id, :scope => :name, :message => "This name already exists."

####################################################################################################

  def apply_message(user_id)
    msg = nil
    application_step = self.procedure_steps.where(:name => "Application").first

    if application_step.is_in_active_time(user_id)
    else
      msg = "The application time is not open now. The application is open from #{application_step.t_start_string_for_landing} to #{application_step.t_end_string_for_landing}"
    end
    return msg
  end

  def get_procedure_positions
    procedure_positions = self.as_json({
      :include => [
        {
          :positions => {
            :include => [
              :role,
              :location
            ]
          }
        }
      ]
    });

    return (procedure_positions);
  end

  def get_procedure_rounds
    procedure_rounds = self.as_json({
      :include => [
        :rounds
      ]
    });

    return (procedure_rounds);
  end

  def get_procedure_round_interviews
    procedure_round_interviews = self.as_json({
      :include => [
        {
          :rounds => {
            :include => [
              :interviews
            ]
          }
        }
      ]
    });

    return (procedure_round_interviews);
  end



  def self.get_procedure_list(table_params, procedure_ids)
    #logger.info "== table_params #{table_params} =="
    order_by_hash = {'Name' => 'procedures.name', 'Status' => 'procedures.status', 'Display Order' => 'procedures.rank'}
    search_fields = ['procedures.name','procedures.status','procedures.rank']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "procedures.rank asc"
    include_condition = [:users, :procedure_mgrs, :rd_mgrs]
    match_condition = ["procedures.status = ? and procedures.disabled is null", "on"]
    procedures = Procedure.includes(include_condition)
                          .references(include_condition)
                          .where(:id => procedure_ids)
                          .where(:year_id => table_params.current_year_id)
                          .where(search_condition)
                          .order(order_condition)
                          .page(table_params.i_page)
                          .per(table_params.i_page_count)
    procedure_list = procedures.as_json(
      {:include => [
        {:procedure_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}},
        {:rd_mgrs => {:include =>
          {:user => {:methods => [:name], :only => :name}}}}],
       :only => [:id, :name, :status, :rank, :acronym, :contact_email, :domain, :faq_url]})

    return procedure_list, procedures.total_count
  end

  def create_new_procedure(year_id)
    begin
      self.status = false
      self.rank = Procedure.where(:year_id => year_id).maximum("rank").to_i + 1
      return false if !self.save!

      ProcedureStep.where({:procedure_id => 0}).order(:rank).each_with_index do |old_procedure_step, index|
        procedure_step = {:procedure_id => self.id,
                          :rank => index + 1,
                          :enabled => old_procedure_step.enabled,
                          :user_view => old_procedure_step.user_view,
                          :name => old_procedure_step.name,
                          :url_acronym => old_procedure_step.url_acronym,
                          :t_start => Time.now(),
                          :t_end => (Time.now() + 2.months)}
        new_procedure_step = ProcedureStep.create(procedure_step)
        ProcedureLanding.create(:procedure_id => self.id, :step_name => old_procedure_step.name)
        ProcedureSubStep.where({:procedure_step_id => old_procedure_step.id}).order(:rank).each_with_index do |old_procedure_sub_step, sub_index|
          procedure_sub_step = {:procedure_step_id => new_procedure_step.id,
                                :rank => sub_index + 1,
                                :enabled => old_procedure_sub_step.enabled,
                                :user_view => old_procedure_sub_step.user_view,
                                :name => old_procedure_sub_step.name,
                                :url_acronym => old_procedure_sub_step.url_acronym,
                                :identify_name => old_procedure_sub_step.identify_name,
                                :t_start => Time.now(),
                                :t_end => (Time.now() + 1.months)}
          new_procedure_sub_step = ProcedureSubStep.create(procedure_sub_step)
        end
      end

      ProcedureSubStep.rebuild_post_interview(self.id);

      recommendation_setting = {:procedure_id => self.id, :number => 0}
      RecommendationSetting.create(recommendation_setting)
      Form.where({:procedure_id => 0}).each do |default_form|
        form = {:procedure_id => self.id,
                :form_type => default_form.form_type,
                :form_name => default_form.form_name,
                :display => default_form.display,
                :rank => default_form.rank,
                :html => default_form.html,
                :schema => default_form.schema
        }
        new_form = Form.create(form)
        if default_form.form_type == "Application"
          FormTag.create(:form_id => new_form.id)
        end
      end
      EmailTemplate.where({:procedure_id => 0}).each do |default_email_template|
        form = {:procedure_id => self.id,
                :title => default_email_template.title,
                :content => default_email_template.content,
                :email_type => default_email_template.email_type,
                :is_active => default_email_template.is_active
        }
        EmailTemplate.create(form)
      end
      SystemMessage.where(:procedure_id => 0).each do |default_system_message|
        system_message = {
          :procedure_id => self.id,
          :name => default_system_message.name,
          :identify_name => default_system_message.identify_name,
          :message => default_system_message.message,
        }
        SystemMessage.create(system_message)
      end

    rescue Exception => e
      logger.error "== create_new_procedure Exception #{e.message} : #{e.backtrace} =="
      return false
    end

    return true
  end

  def self.clone_all_procedure(source_year_id, target_year_id)
    error_messages = []

    Procedure.where(:year_id => source_year_id).each do |source_procedure|
      source_procedure_params = source_procedure.as_json(:only => [:select_position_limit, :name, :acronym, :contact_email, :domain, :faq_url])
      source_procedure_params[:year_id] = target_year_id
      target_procedure = Procedure.create(source_procedure_params)
      if target_procedure.errors.any?
        error_messages << "#{source_procedure.name}: #{Procedure.get_error_messages(target_procedure)}"
      else
        if !target_procedure.clone_procedure(source_procedure.id)
          error_messages << "#{source_procedure.name}: clone error."
          target_procedure.destroy
        end
      end
    end

    return error_messages.empty?, error_messages
  end

  def clone_procedure(procedure_id)
    begin
      source_procedure = Procedure.find_by_id(procedure_id)
      return false if !source_procedure || !source_procedure.year_id || !self.year_id

      change_year = source_procedure.year_id != self.year_id

      self.status = false
      self.contact_email = source_procedure.contact_email
      self.faq_url = source_procedure.faq_url
      self.rank = Procedure.where(:year_id => self.year_id).maximum("rank").to_i + 1
      self.save!

      ProcedureStep.where(:procedure_id => procedure_id).order(:rank).each_with_index do |old_procedure_step, index|
        procedure_step = {
          :procedure_id => self.id,
          :rank => index + 1,
          :enabled => old_procedure_step.enabled,
          :user_view => old_procedure_step.user_view,
          :name => old_procedure_step.name,
          :url_acronym => old_procedure_step.url_acronym,
          :t_start => Time.now(),
          :t_end => (Time.now() + 2.months)
        }
        new_procedure_step = ProcedureStep.create(procedure_step)
        old_procedure_landing = ProcedureLanding.where(:procedure_id => old_procedure_step.procedure_id, :step_name => old_procedure_step.name).first
        ProcedureLanding.create(:procedure_id => self.id, :step_name => old_procedure_step.name, :landing => old_procedure_landing.landing)
        next if new_procedure_step.name == "Interview"
        ProcedureSubStep.where({:procedure_step_id => old_procedure_step.id}).order(:rank).each_with_index do |old_procedure_sub_step, sub_index|
          procedure_sub_step = {
            :procedure_step_id => new_procedure_step.id,
            :rank => sub_index + 1,
            :enabled => old_procedure_sub_step.enabled,
            :user_view => old_procedure_sub_step.user_view,
            :name => old_procedure_sub_step.name,
            :url_acronym => old_procedure_sub_step.url_acronym,
            :identify_name => old_procedure_sub_step.identify_name,
            :lm_see => old_procedure_sub_step.lm_see,
            :t_start => Time.now(),
            :t_end => (Time.now() + 1.months)
          }
          new_procedure_sub_step = ProcedureSubStep.create(procedure_sub_step)
        end
      end

      ProcedureSubStep.rebuild_post_interview(self.id);

      recommendation_setting = RecommendationSetting.find_by_procedure_id(procedure_id)
      new_recommendation_setting = {
        :procedure_id => self.id,
        :number => recommendation_setting.number,
        :show_recommendation => recommendation_setting.show_recommendation,
        :requirement => recommendation_setting.requirement
      }
      RecommendationSetting.create(new_recommendation_setting)
      new_application_form_tag_ids = []
      Form.where(:procedure_id => procedure_id).each do |default_form|
        form = {
          :procedure_id => self.id,
          :form_type => default_form.form_type,
          :form_name => default_form.form_name,
          :display => 0,
          :rank => default_form.rank,
          :html => default_form.html,
          :schema => default_form.schema
        }
        new_form = Form.create(form)
        if default_form.form_type == "Application"
          default_form_tag = FormTag.find_by_form_id(default_form.id)
          # :location_id, :role_id, :position_id use old, replace next
          new_form_tag = FormTag.create(:form_id => new_form.id, :location_id => default_form_tag.location_id, :role_id => default_form_tag.role_id, :position_id => default_form_tag.position_id)
          new_application_form_tag_ids << new_form_tag.id
        end
      end
      EmailTemplate.where(:procedure_id => procedure_id).each do |default_email_template|
        mail_template = {
          :procedure_id => self.id,
          :title => default_email_template.title,
          :content => default_email_template.content,
          :email_type => default_email_template.email_type,
          :is_active => default_email_template.is_active
        }
        EmailTemplate.create(mail_template)
      end

      SystemMessage.where(:procedure_id => procedure_id).each do |default_system_message|
        system_message = {
          :procedure_id => self.id,
          :name => default_system_message.name,
          :identify_name => default_system_message.identify_name,
          :message => default_system_message.message,
        }
        SystemMessage.create(system_message)
      end

      location_id_transform = {}
      Location.where(:procedure_id => procedure_id).each do |default_location|
        location = {
          :procedure_id => self.id,
          :name => default_location.name,
          :tag => default_location.tag
        }
        new_location = Location.create(location)
        location_id_transform[default_location.id] = new_location.id
        FormTag.where(:id => new_application_form_tag_ids, :location_id => default_location.id).update_all(:location_id => new_location.id)
      end
      role_id_transform = {}
      Role.where(:procedure_id => procedure_id).each do |default_role|
        role = {
          :procedure_id => self.id,
          :name => default_role.name,
          :tag => default_role.tag
        }
        new_role = Role.create(role)
        role_id_transform[default_role.id] = new_role.id
        FormTag.where(:id => new_application_form_tag_ids, :role_id => default_role.id).update_all(:role_id => new_role.id)
      end
      Position.where(:procedure_id => procedure_id).each do |default_position|
        position = {
          :procedure_id => self.id,
          :role_id => role_id_transform[default_position.role_id],
          :location_id => location_id_transform[default_position.location_id],
          :vacancy => default_position.vacancy,
          :auto_matching => default_position.auto_matching,
          :tag => default_position.tag,

        }
        new_position = Position.create(position)
        FormTag.where(:id => new_application_form_tag_ids, :position_id => default_position.id).update_all(:position_id => new_position.id)
      end

      UserProcedure.where(:procedure_id => procedure_id).each do |default_user_procedure|
        target_user_id = change_year ? User.get_or_create_other_year_user(default_user_procedure.user_id, self.year_id).id : default_user_procedure.user_id

        user_procedure = {
          :procedure_id => self.id,
          :user_id => target_user_id
        }
        UserProcedure.create(user_procedure)
      end

      ProcedureMgr.where(:procedure_id => procedure_id).each do |default_procedure_mgr|
        target_user_id = change_year ? User.get_or_create_other_year_user(default_procedure_mgr.user_id, self.year_id).id : default_procedure_mgr.user_id

        procedure_mgr = {
          :procedure_id => self.id,
          :user_id => target_user_id
        }
        ProcedureMgr.create(procedure_mgr)
      end
      RdMgr.where(:procedure_id => procedure_id).each do |default_rd_mgr|
        target_user_id = change_year ? User.get_or_create_other_year_user(default_rd_mgr.user_id, self.year_id).id : default_rd_mgr.user_id

        rd_mgr = {
          :procedure_id => self.id,
          :user_id => target_user_id
        }
        RdMgr.create(rd_mgr)
      end
      LocationMgr.where(:location_id => location_id_transform.keys).each do |default_location_mgr|
        target_user_id = change_year ? User.get_or_create_other_year_user(default_location_mgr.user_id, self.year_id).id : default_location_mgr.user_id

        location_mgr = {
          :location_id => location_id_transform[default_location_mgr.location_id],
          :user_id => target_user_id
        }
        LocationMgr.create(location_mgr)
      end
      RoleMgr.where(:role_id => role_id_transform.keys).each do |default_role_mgr|
        target_user_id = change_year ? User.get_or_create_other_year_user(default_role_mgr.user_id, self.year_id).id : default_role_mgr.user_id
        role_mgr = {
          :role_id => role_id_transform[default_role_mgr.role_id],
          :user_id => target_user_id
        }
        RoleMgr.create(role_mgr)
      end

      return true
    rescue Exception => e
      logger.error "== clone_procedure Exception ==#{e.message} : #{e.backtrace}=="
      return false
    end
  end

  def landing(year_id, current_user_id)
    landing_content = self.procedure_landings.where(:step_name => "Process").first.landing
    landing_replace_word = landing_content
    time_hash = {}
    submit_end_time = nil
    recommendation_end_time = nil
    # ..
    process_step_times = ProcedureStep.where(:procedure_id => self.id).select(:id, :name, :t_start, :t_end)
    process_step_times.each do |process_step_time|
      step_name_no_space = process_step_time.name.gsub(" ","")
      landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}StartTime]]", process_step_time.t_start_string_for_landing)
      landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}EndTime]]", process_step_time.t_end_string_for_landing)
      process_sub_step_times = ProcedureSubStep.where(:procedure_step_id => process_step_time.id).select(:name, :t_start, :t_end)
      process_sub_step_times.each do |process_sub_step_time|
        sub_step_name_no_space = process_sub_step_time.name.gsub(" ","")
        landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}-#{sub_step_name_no_space}-StartTime]]", process_sub_step_time.t_start_string_for_landing)
        landing_replace_word = landing_replace_word.gsub("[[#{step_name_no_space}-#{sub_step_name_no_space}-EndTime]]", process_sub_step_time.t_end_string_for_landing)
        if process_step_time.name == "Application" && process_sub_step_time.name == "Submit Application"
          submit_end_time = process_sub_step_time.t_end
        end
        if process_step_time.name == "Application" && process_sub_step_time.name == "Recommendation"
          recommendation_end_time = process_sub_step_time.t_end
        end
      end
    end
    # ..
    round_times = Round.where(:procedure_id => self.id).select(:title, :t_start, :t_end) # If just need interview not post match, add where condition :erasable => true
    round_times.each do |round_time|
      round_title_no_space = round_time.title.gsub(" ","")
      landing_replace_word = landing_replace_word.gsub("[[Round-#{round_title_no_space}-StartTime]]", round_time.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %l:%M %p"))
      landing_replace_word = landing_replace_word.gsub("[[Round-#{round_title_no_space}-EndTime]]",round_time.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %l:%M %p"))
    end
    # ..
    #current_year_name = Year.where(:id => year_id).pluck(:name).first
    current_year = Year.where(:id => year_id).select(:name, :next_year).first
    current_process_data = Procedure.where(:id => self.id).select(:name, :contact_email).first
    landing_replace_word = landing_replace_word.gsub("[[CurrentYear]]", current_year.name.to_s)
    landing_replace_word = landing_replace_word.gsub("[[NextYear]]", current_year.next_year.to_s)
    landing_replace_word = landing_replace_word.gsub("[[CurrentProcess]]", current_process_data.name)
    landing_replace_word = landing_replace_word.gsub("[[ContactEmail]]", (current_process_data.contact_email ? current_process_data.contact_email : ""))
    # ..
    if current_user_id.nil?
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutSubmitApplication]]", "")
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationRequested]]", "")
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationReceived]]", "")
    else
      application_submit_at = Applicant.where(:user_id => current_user_id, :procedure_id => self.id).pluck(:application_submit_at).first
      if !application_submit_at.nil?
        submitted_message = "Your application materials were officially submitted for review on #{application_submit_at.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %l:%M %p")}"
      elsif application_submit_at.nil? && Time.now > submit_end_time
        submitted_message = "The due date has passed. Application materials are no longer being accepted. According to our records, you did NOT officially submit your application materials for review."
      else
        submitted_message = ""
      end
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutSubmitApplication]]", submitted_message)

      recommendation_record_ids = RecommendationRecord.where(:user_id => current_user_id, :procedure_id => self.id, :disabled => false).pluck(:id)
      recommendation_form_length = RecommendationForm.where(:recommendation_record_id => recommendation_record_ids).length
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationRequested]]", recommendation_record_ids == 0 ?  "No recommendations have been requested." : "")
      landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationReceived]]", "#{recommendation_form_length} recommendations have been received.")
    end
    # ..
    landing_replace_word = landing_replace_word.gsub("[[TheMessageAboutRecommendationTimesUp]]", Time.now > recommendation_end_time ? "<b>The due date has passed.</b> Recommendations are no longer being accepted." : "")

    return landing_replace_word
  end

  def landing=(new_landing)
    self.procedure_detail.landing = new_landing
  end

  def application_materials
    return ""# self.procedure_detail.application_materials
  end

  def application_materials=(new_application_materials)
    self.procedure_detail.application_materials = new_application_materials
  end

  def get_all_hiring_mgr_name
    hiring_mgr_ids = ProcedureMgr.where({:procedure_id => self.id}).pluck(:user_id)
    return User.where(:id => hiring_mgr_ids).collect{|user| user.name}.join(", ")
  end

  def self.get_error_messages(active_record)
    error_msgs = []
    active_record.errors.each do |attribute, message|
      error_msgs << message
    end
    return error_msgs.join(" ")
  end

  def no_offered_applicants
    offered_user_ids = Application.where(:offered => ["offered", "post_offered"], :position_id => Position.where(:procedure_id => self.id).collect {|poition| poition.id}).pluck(:user_id)
    applicants = []
    Applicant.includes(:user).where(:disqualify => false, :procedure_id => self.id).where.not(:application_submit_at => nil, :user_id => offered_user_ids).each do |applicant|
      applicants << {
        :id => applicant.id,
        :name => applicant.user.name,
        :email => applicant.user.email,
        :invited => false
      }
    end
    return applicants
  end

  def self.admin_and_hiring_mgr_emails(i_procedure_id)
    procedure = Procedure.find_by_id(i_procedure_id);
    hiring_mgr_ids = ProcedureMgr.joins(:user).where(:procedure_id => i_procedure_id).pluck(:email)
    admin_ids = User.where(:year_id => procedure.year_id, :is_admin => true).pluck(:email)
    return (hiring_mgr_ids + admin_ids).uniq
  end

  def self.all_position_match_forms(procedure_id)
    position_match_forms = {}
    location_match_positions = {}
    role_match_positions = {}
    Position.where(:procedure_id => procedure_id).each do |position|
      position_match_forms[position.id] = []
      location_match_positions[position.location_id] = [] unless location_match_positions.has_key?(position.location_id)
      location_match_positions[position.location_id] << position.id
      role_match_positions[position.role_id] = [] unless role_match_positions.has_key?(position.role_id)
      role_match_positions[position.role_id] << position.id
    end

    Form.where(:procedure_id => procedure_id, :form_type => "Application", :display => true).each do |form|
      form_tags = FormTag.where(:form_id => form.id)
      form_match_position_ids = form_tags.select { |form_tag| form_tag.position_id }.collect { |form_tag| form_tag.position_id }
      form_match_location_ids = form_tags.select { |form_tag| form_tag.location_id }.collect { |form_tag| form_tag.location_id }
      form_match_role_ids     = form_tags.select { |form_tag| form_tag.role_id     }.collect { |form_tag| form_tag.role_id }
      if (form_match_position_ids + form_match_location_ids + form_match_role_ids).blank?
        position_match_forms.each do |key, value|
          position_match_forms[key] << form.id
        end
      else
        #logger.info "== position_match_forms     #{position_match_forms} =="
        #logger.info "== location_match_positions #{location_match_positions} =="
        #logger.info "== role_match_positions     #{role_match_positions} =="
        #logger.info "== form_match_position_ids  #{form_match_position_ids} =="
        #logger.info "== form_match_location_ids  #{form_match_location_ids} =="
        #logger.info "== form_match_role_ids      #{form_match_role_ids} =="
        #logger.info "== form.id                  #{form.id} =="
        if form_match_position_ids.present?
          form_match_position_ids.each do |position_id|
            position_match_forms[position_id] << form.id
          end
        end
        if form_match_location_ids.present?
          form_match_location_ids.each do |location_id|
            position_ids = location_match_positions[location_id]
            position_ids.each do |position_id|
              position_match_forms[position_id] << form.id
            end if position_ids
          end
        end
        if form_match_role_ids.present?
          form_match_role_ids.each do |role_id|
            position_ids = role_match_positions[role_id]
            position_ids.each do |position_id|
              position_match_forms[position_id] << form.id
            end if position_ids
          end
        end
      end
    end
    return position_match_forms
  end

  def self.forms_and_questions(procedure_id, permission_form_ids = nil)
    hash = {}
    hash["System Forms"] = {}
    hash["Attachable Forms"] = {}
    hash["Recommendations"] = {}
    #logger.info "== procedure_id #{procedure_id} =="
    Form.where(:procedure_id => procedure_id, :display => true).each do |form|
      if form.form_type == "System"
        hash["System Forms"][form.form_name] = form.questions
      elsif form.form_type == "Application"
        hash["Attachable Forms"][form.form_name] = form.questions if !permission_form_ids || (permission_form_ids && permission_form_ids.include?(form.id))
      elsif form.form_type == "Recommender"
        hash["Recommendations"][form.form_name] = form.questions
      end
    end
    return hash
  end

end
