class RecommendationFormsController < ApplicationController

  def index
    record_inside = RecommendationRecord.find_by_id(params[:rid])
    record_outside = JSON.parse(Base64.urlsafe_decode64(params[:token].gsub('_','='))) if !params[:token].nil?
    permission_to_active = ProcedureSubStep.is_in_active_time(record_inside.procedure_id, "recommendation", session[:user_id])

    render :json => { :success => false, :msg => "The recommendation request has expired." } and return if !permission_to_active
    render :json => { :success => false, :msg => "Invalid URL" } and return if (record_inside.token && params[:key] != record_inside.token)

    if record_inside.email.match(/@stanford.edu$/)
=begin
      if current_user && (current_user.email == record_inside.email)
      else
        logger.info "Current user is not the recommender."
        render :json => {:success => false, :msg => "Invalid Stanford recommender(s)"} and return
      end
=end
    elsif record_outside["id"] != record_inside.id || record_outside["name"] != record_inside.name || record_outside["email"] != record_inside.email
      render :json => {:success => false, :msg => "Invalid Recommender(s) out of Stanford"} and return
    end
    recommendation_forms = RecommendationForm.where(:recommendation_record_id => record_inside.id)
    user_id = record_inside.user_id;

    if recommendation_forms.length == 0
      recommendation_forms = Form.where(:id => record_inside.recommendation_form_id).select(:id, :form_name, :schema)
      recommendation_forms.each do |form|
        form.id = record_inside.id
      end
    end


    recommendation_forms.each do |form|
      form.schema = Form.data_binding(form.schema, nil, nil)
    end

    applicant = User.find_by_id(user_id);
    if (applicant.present?)
      s_applicant_name = applicant.name;
    end

    show_recommendation_option = RecommendationSetting.where(:procedure_id => record_inside.procedure_id).select(:show_recommendation).first.show_recommendation

    render :json => {
             :success => true,
             :this_record => record_inside,
             :recommendation_form => recommendation_forms,
             :show_recommendation_option => show_recommendation_option,
             :permission_to_active => permission_to_active,
             :applicant_name => s_applicant_name
           }
  end

  def show
    @recommendation_form = RecommendationForm.schema_add_name_relationship(RecommendationForm.find_by_id(params[:id]))
    logger.info("id : #{params[:id]}");
    logger.info("@recommendation_form : #{@recommendation_form.to_json}");
    if @recommendation_form
      render :json => {:success => true, :form => @recommendation_form}
    else
      render :json => {:success => false}
    end
  end

  def fill_recommendation_form
    recommendation_form = RecommendationForm.where(:recommendation_record_id => params[:recommendation_record_id]).first

    if !recommendation_form
      recommendation_form = RecommendationForm.new(
                              :recommendation_record_id => params[:recommendation_record_id],
                              :form_name => params[:form_name],
                              :schema => params[:schema],
                              :recommender_sunet_id => current_user ? current_user.sunet_id : "")
      recommendation_form.save
      upload_files = UploadFile.where(:recommendation_form_id => params[:recommendation_record_id])
      upload_files.update_all(:recommendation_form_id => recommendation_form.id)
    else
      recommendation_form.update_attributes(:schema => params[:schema])
    end

    this_record = RecommendationRecord.find_by_id(params[:recommendation_record_id])
    this_record.update_attributes(:show_for_std_interviewers => params[:show_for_std_interviewers], :submit_date => Time.at(params[:submit_datetime]))
    recommender_submit_temp = EmailTemplate.where(
                                :procedure_id => this_record.procedure_id,
                                :email_type => "notice_recommender_submit",
                                :is_active => true)
                              .select(:title, :content).first
    recommender_submit_temp = EmailTemplate.where(
                                :procedure_id => this_record.procedure_id,
                                :email_type => "notice_recommender_submit")
                              .select(:title, :content).first if !recommender_submit_temp
    applicant_get_temp = EmailTemplate.where(
                           :procedure_id => this_record.procedure_id,
                           :email_type => "notice_applicant_get",
                           :is_active => true)
                         .select(:title, :content).first
    applicant_get_temp = EmailTemplate.where(
                           :procedure_id => this_record.procedure_id,
                           :email_type => "notice_applicant_get")
                         .select(:title, :content).first if !applicant_get_temp
    sent_to_recommender = replace_email_word(recommender_submit_temp.title, recommender_submit_temp.content, this_record)
    sent_to_applicant = replace_email_word(applicant_get_temp.title, applicant_get_temp.content, this_record)
    StanfordMailer.send_shipped(this_record.email, sent_to_recommender[:title], sent_to_recommender[:content])
    user_email = User.where(:id => this_record.user_id).select("email").first
    StanfordMailer.send_shipped(user_email.email, sent_to_applicant[:title], sent_to_applicant[:content])

    render :json => recommendation_form
  end

  def redir
    session[:return_url] = "https://#{request.host}/saas/app/index.html#/recommendation_form?rid=#{params[:rid]}&key=#{params[:key]}"
    redirect_to session[:return_url]
  end

  def replace_email_word(ori_title, ori_content, recommendation_record)
    if STANFORD68 || (Rails.env == "production")
      recommendation_form_url = "https://" + request.host
    else
      recommendation_form_url = "http://" + request.host_with_port
    end

    if recommendation_record.email.match(/@stanford.edu$/)
      recommendation_form_url += "/recommendation_forms/redir?rid=" + recommendation_record.id.to_s
    else
      token = Base64.urlsafe_encode64(recommendation_record.to_json)
      recommendation_form_url += "/saas/index.html#/recommendation_form?rid=" + recommendation_record.id.to_s + "&token=" + token.gsub('=','_')
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
