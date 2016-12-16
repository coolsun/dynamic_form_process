class Applicant < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :procedure;
  has_many :applicant_tags, :dependent => :destroy;
  has_many :comments, :dependent => :destroy;

  def offer_application
    return Application.joins(:position).where(:user_id => self.user_id, :positions => {:procedure_id => self.procedure_id}, :offered => ["offered", "post_offered"]).first
  end

  def offer_status
    application = self.offer_application
    if !application
      status = "not offered"
    elsif application.offer_accept == "accepted"
      status = "accepted"
    elsif application.offer_accept == "rejected"
      status = "decline"
    elsif application.offer_accept.blank?
      status = "wait for confirmation"
    else
      status = "other"
    end
    return status
  end

  def offered_position
    return self.offer_application.try(:position)
  end

  def have_offer
    return self.offer_application.present?
  end

  def ranking_position_names
    if self.application_submit_at
      return Application.joins(:position).where(:positions => {:procedure_id => self.procedure_id}, :user_id => self.user_id, :disable_user_rank => nil, :offered => "wait").order(:user_rank => :asc).collect{|o| o.position.name}
    else
      return ""
    end
  end

  def preferred_name
    preferred_name = ""
    form_ids = Form.where(:procedure_id => self.procedure_id, :form_type => "System", :display => true).pluck(:id)

    return preferred_name if form_ids.blank?

    user_form_ids = UserForm.where(:form_id => form_ids, :user_id => self.user_id, :procedure_id => self.procedure_id).pluck(:id)

    return preferred_name if user_form_ids.blank?

    form_inputs = FormInput.where("schema_description like '%Preferred Name%' and form_table = 'USER_FORMS' and form_id in (?)", user_form_ids)

    form_inputs.each do |form_input|
      preferred_name = form_input.schema_value if form_input.schema_value.present?
    end

    return preferred_name
  end

  def submit_and_not_disqualify
    return self.application_submit_at && !self.disqualify
  end

  def status
    if self.disqualify
      status = "Disqualified"
    elsif self.application_submit_at
      status = "Submitted"
    else
      status = "Not Submitted"
    end
    return status
  end

  def application_submit_at_string
    return self.application_submit_at.kind_of?(Time) ? self.application_submit_at.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M %p") : ""
  end

  def self.apply(i_user_id, i_procedure_id)
    applicant = Applicant.new(
      :user_id => i_user_id,
      :procedure_id => i_procedure_id
    );
    applicant.save();
    applicant.update_peoplesoft_and_transcripts
    return applicant;
  end

  def self.get_applicant_list(table_params, filter_options, current_user_status, display_rd_flag_button, current_user)
    logger.info "== table_params #{table_params} =="
    order_by_hash = {'First Name' => 'lower(users.first_name)', 'Last Name' => 'lower(users.last_name)', 'Name' => 'lower(users.first_name)', 'Email' => 'users.email', 'Submitted' => 'applicants.application_submit_at'}
    search_fields = ['users.first_name', 'users.middle_name', 'users.last_name', 'users.email', 'users.suid', 'users.sunet_id']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "users.last_name asc"
    procedure_id = table_params.i_procedure_id
    applicant_list = []
    forms_and_questions_hash = {}

    filter_where_condition, filter_where_not_condition = self.applicant_list_setting_where_condition(filter_options, procedure_id)

    if filter_options[:question_filters].present?
      question_filters_user_ids = FormInput.question_filters_user_ids(filter_options[:question_filters], procedure_id)
      logger.info "== question_filters_user_ids #{question_filters_user_ids} =="
      if question_filters_user_ids.blank?
        filter_match_question_applicants = "applicants.user_id = 0"
      else
        query = []
        question_filters_user_ids = question_filters_user_ids.in_groups_of(1000, false)
        question_filters_user_ids.each do |question_filters_user_ids_of_1000|
          #logger.info "== question_filters_user_ids_of_1000 #{question_filters_user_ids_of_1000} =="
          query << "applicants.user_id in (#{question_filters_user_ids_of_1000.join(',')})"
        end
        filter_match_question_applicants = query.join(' or ')
      end
    else
      filter_match_question_applicants = ""
    end

    all_applicants_emails = Applicant.includes(:user => [{:applications => {:position => [:location, :role]}}, {:invitees => :interview}])
                    .where(:procedure_id => procedure_id)
                    .where(filter_where_condition)
                    .where.not(filter_where_not_condition)
                    .where(filter_match_question_applicants)
                    .where(search_condition)
                    .order("name")
                    .distinct.pluck("REPLACE(TRIM(users.first_name)||' '||TRIM(users.middle_name)||' '||TRIM(users.last_name), '  ', ' ') as name, users.email").map{|applicant| {:name => applicant[0], :email => applicant[1]}};

    applicants = Applicant.includes(:user => [{:applications => {:position => [:location, :role]}}, {:invitees => :interview}])
                    .where(:procedure_id => procedure_id)
                    .where(filter_where_condition)
                    .where.not(filter_where_not_condition)
                    .where(filter_match_question_applicants)
                    .where(search_condition)
                    .order(order_condition).page(table_params.i_page).per(table_params.i_page_count)

    position_match_forms = Procedure.all_position_match_forms(procedure_id)

    # forms_and_questions_hash
    position_forms = []
    filter_options[:permission_positions].each do |position_id|
      position_forms = position_forms + position_match_forms[position_id]
    end
    forms_and_questions_hash = Procedure.forms_and_questions(procedure_id, position_forms.uniq)
    #logger.info "== #{forms_and_questions_hash} forms_and_questions_hash =="

    # applicants each do
    applicants_length = 0
    applicants.each do |applicant|
      applicant_offerd_position = applicant.user.applications.select{|application| application.offered == "offered" || application.offered == "post_offered" }
      if applicant_offerd_position.present?
        applicant_offerd = "Y"
        applicant_accepted = (applicant_offerd_position.select{|application| application.offer_accept == "accepted"}.present? ? "Y" : "N")
      else
        applicant_offerd = "N"
        applicant_accepted = "N"
      end

      # applicant system_forms
      applicant_system_forms = []
      applicant.procedure.forms.select(:id, :procedure_id, :form_type, :form_name, :display, :rank, :schema).where({:form_type => "System", :display => true}).each do |form|
        user_filled_system_form = UserForm.where(:form_id => form.id, :user_id => applicant.user_id).where.not(:submit_date => nil).select(:id, :form_id, :user_id, :form_name).first
        applicant_system_forms << user_filled_system_form if user_filled_system_form
      end

      # applicant application_forms
      position_forms = []
      applicant_application_forms = []
      application_filter_where_condition = {}
      application_filter_where_condition[:user_id] = applicant.user_id
      application_filter_where_condition[:position] = filter_options[:permission_positions] if filter_options[:permission] == 'LM'
      Position.where(:id => Application.where(application_filter_where_condition).pluck(:position_id), :procedure_id => procedure_id).each do |position|
        position_forms = position_forms + position_match_forms[position.id]
      end
			position_forms.uniq.each do |form_id|
			  user_from = UserForm.where(:form_id => form_id, :user_id => applicant.user_id).where.not(:submit_date => nil).first
			  if user_from.present?
  			  applicant_application_forms << {
  			    "id" => user_from.id,
  			    "form_name" => user_from.form_name
  			  }
  			end
			end

      # applicant recommendation_forms
      applicant_recommendation_forms = []
      applicant.procedure.recommendation_records.where(:user_id => applicant.user_id).each do |recommendation_record|
        next if !recommendation_record || !recommendation_record.recommendation_form || recommendation_record.disabled
        form = RecommendationForm.select(:id, :form_name).find_by_recommendation_record_id(recommendation_record.id)
        if current_user_status != "Student" || (current_user_status == "Student" && recommendation_record.show_for_std_interviewers)
          applicant_recommendation_forms << {
            "id" => form.id,
            "form_name" => form.form_name,
            "recommender" => recommendation_record.name
          }
        end
      end

      applicant_interview_forms = []
      transcripts = []

      # show applicant select positions
      applicant_poitions = []
      if filter_options[:permission] == 'admin'
        applicant_poitions = Position.includes(:applications).where(:procedure_id => procedure_id, :applications => {:user_id => applicant.user_id}).pluck(:name)
      elsif ['LM', 'RMLM'].include?(filter_options[:permission])
        applicant_poitions = Position.includes(:applications).where(:applications => {:user_id => applicant.user_id, :position_id => filter_options[:permission_positions]}).pluck(:name)
      else
        applicant_poitions = ["Only admin or LM can see that."]
      end

      applicant_interviews = [];
      if (['admin', 'RM'].include?(filter_options[:permission]))
        applicant_interviews = Round.joins(:interviews => :invites).where(:procedure_id => procedure_id, :invites => {:invitee_user_id => applicant.user_id}).pluck(:title)
      end
      location_ids = Location.includes(:positions).where(positions: {name: applicant_poitions}, procedure_id: procedure_id).map(&:id)
      comments, can_comment = Applicant.get_applicant_comment(applicant, current_user, procedure_id)

      applicant_list << {
        :id => applicant.user.id,
        :rd_flag_color => display_rd_flag_button ? applicant.rd_flag_color : nil,
        :disqualify => applicant.disqualify,
        :first_name => applicant.user.first_name,
        :last_name => applicant.user.last_name,
        :name => User.get_preferred_name(applicant.user_id),
        :email => applicant.user.email,
        :submited => applicant.try(:application_submit_at) ? "Y" : "N",
        :system_forms => applicant_system_forms,
        :user_forms => applicant_application_forms,
        :recommendation_forms => applicant_recommendation_forms,
        :interview_forms => applicant_interview_forms,
        :transcripts => {:grades => transcripts},
        :positions => applicant_poitions.join(", "),
        :interviews => applicant_interviews.join(", "),
        :offered => applicant_offerd,
        :accepted => applicant_accepted,
        :comments => comments,
        :applicant_id => applicant.id,
        :can_comment => can_comment
      }

      applicants_length += 1
    end
    return applicant_list, applicants.total_count, forms_and_questions_hash, all_applicants_emails
  end

  def self.get_applicant_comment(applicant, current_user, procedure_id)
    can_comment = false
    role = ""
    block = ""
    comments = []

    logger.info("=======================")
    logger.info("applicant: #{applicant.to_json}")
    logger.info("current_user: #{current_user.to_json}")
    logger.info("procedure_id: #{procedure_id}")
    logger.info("=======================")
    # if is_location_mgr, pluck location_ids
    this_procedure_location_ids = Location.includes(:procedure).where(procedure_id: procedure_id).pluck(:id)
    current_user_location_ids = LocationMgr.where(:location_id => this_procedure_location_ids, :user_id => current_user.id).pluck(:location_id)

    # location_ids = location_ids.present? ? location_ids : []
    is_admin = current_user.is_admin
    is_hiring_mgr = ProcedureMgr.where(:procedure_id => procedure_id, :user_id => current_user.id).present?
    is_location_mgr = current_user_location_ids.present?

    if is_admin || is_hiring_mgr
      role = "Admin/HM"
    elsif is_location_mgr
      role = "LM"
    else
      role = "none"
    end

    if is_admin || is_hiring_mgr || is_location_mgr
      can_comment = true
    end

    all_comments = Comment.includes(:comment_in_locations).where(applicant_id: applicant.id)
    if all_comments.present?
      all_comments.each do |comment|
        comment_tmp = {}
        comment_tmp[:id] = comment.id
        comment_tmp[:comment] = comment.comment
        comment_tmp[:comment_by] = comment.comment_by
        if role == "Admin/HM"
          comment_tmp[:can_see] = true
          comment_tmp[:block] = "A"
        elsif role == "LM" #location_mgr only can see same location's mgr comment
          if comment.comment_by == current_user.first_name
            comment_tmp[:can_see] = true
            comment_tmp[:block] = "B"
          else
            #if can_see_location_ids is empty, means this comment comment by admin or HM
            can_see_location_ids  = comment.comment_in_locations.pluck(:location_id)
            comment_tmp[:can_see] = (can_see_location_ids.empty? | (current_user_location_ids & can_see_location_ids).present?) ? true : false
            comment_tmp[:block] = "C"
          end
        else
          comment_tmp[:can_see] = false
          comment_tmp[:block] = "D"
        end
        comments << comment_tmp
      end
    end
    return comments, can_comment
  end

  def self.applicant_list_setting_where_condition(filter_options, procedure_id)
    filter_where_condition = {}
    filter_where_not_condition = {}

    if filter_options[:locations].present?
      filter_where_condition[:locations] = {:id => filter_options[:locations]}
    end

    if filter_options[:roles].present?
      filter_where_condition[:roles] = {:id => filter_options[:roles]}
    end

    if filter_options[:interviews].present?
      filter_where_condition[:interviews] = {:id => filter_options[:interviews]}
    end

    unless filter_options[:includes_disqualified]
      filter_where_condition[:disqualify] = false
    end

    if filter_options[:status] == 'Submitted'
      filter_where_not_condition[:application_submit_at] = nil
    elsif filter_options[:status] == 'Not submitted'
      filter_where_condition[:application_submit_at] = nil
    elsif filter_options[:status] == 'Offered'
      filter_where_condition[:applications] = {:offered => ["offered", "post_offered"]}
    elsif filter_options[:status] == 'Un-offered'
      offered_user_ids = Application.includes(:position).where(:offered => ["offered", "post_offered"], :positions => {:procedure_id => procedure_id}).pluck(:user_id)
      filter_where_not_condition[:users] = {:id => offered_user_ids}
    elsif filter_options[:status] == 'Accepted'
      filter_where_condition[:applications] = {:offer_accept => "accepted"}
    elsif filter_options[:status] == 'Unaccepted'
      filter_where_not_condition[:applications] = {:offer_accept => "accepted"}
    elsif filter_options[:status] == 'Disqualify'
      filter_where_condition[:disqualify] = true
    end

    # LM can not see disqualify applicants and not submit applicant
    if filter_options[:permission] == 'LM' # means only LM
      filter_where_condition[:disqualify] = false
      filter_where_not_condition[:application_submit_at] = nil
    end

    return filter_where_condition, filter_where_not_condition
  end

  def self.is_application_sumbit(user_id, procedure_id)
    if Applicant.where("user_id = ? and procedure_id = ? and application_submit_at is not null", user_id, procedure_id).length > 0
      return true
    else
      return false
    end
  end

  def name
    return self.user.name
  end

  def self.is_get_offered(user_id, procedure_id, is_post)
    applications = Application.joins(:position).where(:user_id => user_id, :positions => {:procedure_id => procedure_id}, :offered => is_post ? "post_offered" : "offered")
    is_get_offered = applications.present?
    is_accept_offered = applications.select {|application| application.offer_accept == "accepted"}.present?
    return is_get_offered, is_accept_offered
  end

  def update_peoplesoft_and_transcripts
    logger.info("============= update_peoplesoft_and_transcripts =================")
    user = User.find_by_id(self.user_id)
    Transcript.get_grades(user)
    user_peoplesoft = PeoplesoftDetail.where(:user_id => user.id).first
    if user_peoplesoft && (Rails.env == "production" || STANFORD68) && Time.now() - user_peoplesoft.updated_at > 1.day
      client = PeoplesoftDetail.get_people_soft(user.sunet_id)
      message = client.get();
      if (message)
        logger.info("# #{Time.now}, action: ApplicantsController, create_user, stanford_SSL_saservice2_message #{message}");
        json_message = JSON.parse(message);
        httpStatusCode = json_message["httpStatusCode"];

        if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
          # error
          # 1. httpStatusCode = 401: not an authorized.
          # 2. {"errorMessage":"System can not find the target student identified by bsun2"}

          error_msg = "# #{Time.now}, action: ApplicantsController, at production create_user, parse message, sunet_id: #{user.sunet_id}"
          logger.error(error_msg)
          StanfordMailer.send_admin("Get Peoplesoft Fail", error_msg).deliver
        else
          peoplesoft = User.parse_peoplesoft(json_message);

          first_name = peoplesoft.first_name;
          middle_name = peoplesoft.middle_name;
          last_name = peoplesoft.last_name;
          suid = peoplesoft.suid;
          email = peoplesoft.email;
          sunet_id = peoplesoft.sunet_id;
          gender = peoplesoft.gender;
          housingRemainYears = peoplesoft.housingRemainYears;
          academicStandings = peoplesoft.academicStandings;
          academics = peoplesoft.academics;
          addresses = peoplesoft.addresses;
          phones = peoplesoft.phones;

          user.update(
            :first_name => first_name,
            :middle_name => middle_name,
            :last_name => last_name,
            :suid => suid,
            :email => email,
            :sunet_id => sunet_id,
            :gender => gender,
            :academic_year_remaining => housingRemainYears,
          );

          user_peoplesoft.update(
            :academics => academics,
            :addresses => addresses,
            :phones => phones,
            :academic_standings => academicStandings
          )
        end
      end
    end

    return true
  end

  def self.get_applicants(table_params, filter_options)
    filter_where_condition, filter_where_not_condition = self.applicant_list_setting_where_condition(filter_options, procedure_id)
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "users.last_name asc"

    if filter_options[:question_filters].present?
      question_filters_user_ids = FormInput.question_filters_user_ids(filter_options[:question_filters], procedure_id)
      logger.info "== question_filters_user_ids #{question_filters_user_ids} =="
      if question_filters_user_ids.blank?
        filter_match_question_applicants = "applicants.user_id = 0"
      else
        query = []
        question_filters_user_ids = question_filters_user_ids.in_groups_of(1000, false)
        question_filters_user_ids.each do |question_filters_user_ids_of_1000|
          #logger.info "== question_filters_user_ids_of_1000 #{question_filters_user_ids_of_1000} =="
          query << "applicants.user_id in (#{question_filters_user_ids_of_1000.join(',')})"
        end
        filter_match_question_applicants = query.join(' or ')
      end
    else
      filter_match_question_applicants = ""
    end

    applicants = Applicant.includes(:user => [{:applications => {:position => [:location, :role]}}, {:invitees => :interview}])
                          .where(:procedure_id => procedure_id)
                          .where(filter_where_condition)
                          .where.not(filter_where_not_condition)
                          .where(filter_match_question_applicants)
                          .where(search_condition)
                          .order(order_condition)
  end
end
