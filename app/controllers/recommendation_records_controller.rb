class RecommendationRecordsController < ApplicationController

  def index
    procedure_id = params[:current_process_id]
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Recommendation")


    records = RecommendationRecord.where(
      :user_id => params[:user_id],
      :procedure_id => procedure_id
    ).order(:created_at => :asc).as_json(:methods => [:created_at_string, :submit_date_string])
    settings = RecommendationSetting.where(:procedure_id => procedure_id)

    recommendation_forms = Form.where(
      :procedure_id => procedure_id,
      :form_type => 'Recommender',
      :display => true
    ).select(:id, :form_name)

    position_selected_count = Application.joins(:position).where(
      :user_id => params[:user_id],
      #:offered => "wait",
      :positions => {
        :procedure_id => procedure_id
      }
    ).count
    #position_selected_count = 0 # test no position selected

    render :json => {
      :success => false,
      :records => records,
      :settings => settings,
      :recommendation_forms => recommendation_forms,
      :permission_to_active => false,
      :msg => "Select a position at least."
    } and return if position_selected_count == 0

    render :json => {
      :success => true,
      :records => records,
      :settings => settings,
      :recommendation_forms => recommendation_forms,
      :permission_to_active => permission_to_active
    }
  end

  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Recommendation")
    records = RecommendationRecord.where(
      :user_id => params[:user_id],
      :procedure_id => params[:procedure_id]
    ).order(:created_at => :asc)

    render :json => {
      :success => false,
      :msg => permission_message,
      :records => records
    } and return if !permission_to_active

    render :json => {
      :success => false,
      :msg => "Please fill in all the required informations (*) without any blank.",
      :records => records
    } and return if !(params[:name] && params[:title] && params[:relationship] && params[:email])

    duplicate_email_record = RecommendationRecord.where(
      :user_id => params[:user_id],
      :procedure_id => params[:procedure_id],
      :email => params[:email],
      :recommendation_form_id => params[:recommendation_form_id]
    ).first

    render :json => {
      :success => false,
      :msg => "Warning: the same email and form has been sent again!",
      :records => records
    } and return if duplicate_email_record

    last_record = RecommendationRecord.create(
      :user_id => params[:user_id],
      :procedure_id => params[:procedure_id],
      :recommendation_form_id => params[:recommendation_form_id],
      :name => params[:name],
      :title => params[:title],
      :relationship => params[:relationship],
      :email => params[:email],
      :token => SecureRandom.uuid
    )
    render :json => {:success => false, :msg => "Request delivery failed", :records => records} and return if !last_record

    recommendation_invite_email_temp = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => "invite_recommender",
      :is_active => true
    ).select(:title, :content).first

    recommendation_invite_email_temp = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => "invite_recommender"
    ).select(:title, :content).first if !recommendation_invite_email_temp

    sent_to_recommender = replace_email_word(recommendation_invite_email_temp.title, recommendation_invite_email_temp.content, last_record)
    StanfordMailer.send_shipped(last_record.email, sent_to_recommender[:title], sent_to_recommender[:content])

    applicant_send_email_temp = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => "notice_applicant_send",
      :is_active => true
    ).select(:title, :content).first

    applicant_send_email_temp = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => "notice_applicant_send"
    ).select(:title, :content).first if !applicant_send_email_temp

    sent_to_applicant = replace_email_word(applicant_send_email_temp.title, applicant_send_email_temp.content, last_record)
    user_email = User.where(:id => params[:user_id]).first.email
    StanfordMailer.send_shipped(user_email, sent_to_applicant[:title], sent_to_applicant[:content])

    records = RecommendationRecord.where(:user_id => params[:user_id], :procedure_id => params[:procedure_id]).order(:created_at => :asc)
    render :json => {:success => true, :msg => "Request delivery success", :records => records}
  end

  def update
    disable_record = RecommendationRecord.find_by_id(params[:id])
    disable_record.update_attributes(:disabled => !disable_record.disabled)

    render :json => {:disabled => disable_record.disabled}
  end

  def send_reminder_email
    reminder_record = RecommendationRecord.where(:id => params[:recommendation_record_id]).first

    remind_email_temp = EmailTemplate.where(
      :procedure_id => reminder_record.procedure_id,
      :email_type => "remind_recommender",
      :is_active => true
    ).select(:title, :content).first

    remind_email_temp = EmailTemplate.where(
      :procedure_id => reminder_record.procedure_id,
      :email_type => "remind_recommender"
    ).select(:title, :content).first if !remind_email_temp

    sent_to_recommender = replace_email_word(remind_email_temp.title, remind_email_temp.content, reminder_record)
    StanfordMailer.send_shipped(reminder_record.email, sent_to_recommender[:title], sent_to_recommender[:content])

    render :nothing => true
  end

  def replace_email_word(ori_title, ori_content, recommendation_record)
    if STANFORD68 || (Rails.env == "production")
      recommendation_form_url = "https://" + request.host
    else
      recommendation_form_url = "http://" + request.host_with_port
    end

    if recommendation_record.email.match(/@stanford.edu$/)
      recommendation_form_url += "/recommendation_forms/redir?rid=" + recommendation_record.id.to_s + "&key=" + recommendation_record.token.to_s
    else
      token = Base64.urlsafe_encode64(recommendation_record.to_json)
      recommendation_form_url += "/saas/index.html#/recommendation_form?rid=" + recommendation_record.id.to_s + "&token=" + token.gsub('=','_') + "&key=" + recommendation_record.token.to_s
    end

    applicant_data = User.where(:id => recommendation_record.user_id).select(:first_name, :middle_name, :last_name, :email).first
    applicant_full_name = applicant_data.first_name
    applicant_full_name += " " + applicant_data.middle_name if applicant_data.middle_name != nil
    applicant_full_name += " " + applicant_data.last_name if applicant_data.last_name != nil
    procedure_data = Procedure.where(:id => recommendation_record.procedure_id).select(:name).first

    current_year = Year.where(:is_current_year => true).select(:name, :next_year).first

    get_procedure_mgrs_user_id = ProcedureMgr.where(:procedure_id => recommendation_record.procedure_id).pluck(:user_id)
    procedure_mgr_datas = User.where(:id => get_procedure_mgrs_user_id).as_json(:methods => :name)
    procedure_mgr_names = []
    procedure_mgr_datas.each do |procedure_mgr_data|
      procedure_mgr_names << procedure_mgr_data["name"]
    end
    get_step_application_id = ProcedureStep.where(:procedure_id => recommendation_record.procedure_id, :name => "Application").pluck(:id).first
    get_sub_step_recommendation_endtime = ProcedureSubStep.where(
                                            :procedure_step_id => get_step_application_id,
                                            :identify_name => "recommendation")
                                          .pluck(:t_end).first
    get_role_names = User.find_by_id(recommendation_record.user_id).get_user_all_role_names(recommendation_record.procedure_id)
    get_position_names = User.find_by_id(recommendation_record.user_id).get_user_all_position_names(recommendation_record.procedure_id)

    new_title = ori_title
    new_title = new_title.gsub('[[RecommenderName]]', recommendation_record.name)
    new_title = new_title.gsub('[[ApplicantName]]', applicant_full_name)
    new_title = new_title.gsub('[[ProcessName]]', procedure_data.name)

    new_content = ori_content
    new_content = new_content.gsub('[[Roles]]', get_role_names)
    new_content = new_content.gsub('[[Positions]]', get_position_names)
    new_content = new_content.gsub('[[RecommenderName]]', recommendation_record.name.to_s)
    new_content = new_content.gsub('[[RecommenderTitle]]', recommendation_record.title.to_s)
    new_content = new_content.gsub('[[RecommenderRelationship]]', recommendation_record.relationship.to_s)
    new_content = new_content.gsub('[[RecommenderEmail]]', recommendation_record.email.to_s)
    new_content = new_content.gsub('[[ApplicantName]]', applicant_full_name)
    new_content = new_content.gsub('[[ApplicantEmail]]', applicant_data.email)
    new_content = new_content.gsub('[[ProcessName]]', procedure_data.name)

    new_content = new_content.gsub('[[CurrentYear]]', current_year.name.to_s)
    new_content = new_content.gsub('[[NextYear]]', current_year.next_year.to_s)

    new_content = new_content.gsub('[[HiringManagerName]]', procedure_mgr_names.join(", ").strip)
    new_content = new_content.gsub('[[RecommendationEndDate]]', get_sub_step_recommendation_endtime.to_s)
    new_content = new_content.gsub('[[RecommendationFormURL]]', '<a href="' + recommendation_form_url + '">Go to recommend</a><br /><b style="color: red;">Kindly note that if your email address is with "@stanford.</b><b style="color: red;">edu", you need to log in Webauth first and then hit "go to recommend" link to fill in the form. Thank you.</b>')
    new_content = new_content.gsub('[[RecommendationRequestDate]]', recommendation_record.created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M PST"))

    return { :title => new_title, :content => new_content }
  end
end
