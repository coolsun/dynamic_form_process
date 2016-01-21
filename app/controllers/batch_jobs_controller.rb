class BatchJobsController < ApplicationController

  def delete_version
    #PaperTrail::Version.delete_all ["created_at < ?", 1.week.ago]

    version = PaperTrail::Version.order(:id => :desc).limit(1).offset(500000).first
    PaperTrail::Version.delete_all ["id <= ?", version.id] if version

    render :text => "done"
  end

  def translate_form_schema
    begin
      #FormInput.delete_all
      current_year_id = Year.find_by_is_current_year(true).id
      procedure_ids = Procedure.where(:year_id => current_year_id).pluck(:id)
      #procedure_ids = Procedure.all.pluck(:id)
      UserForm.where(:procedure_id => procedure_ids).where.not(:submit_date => nil).each do |user_form|
        FormInput.where(:form_id => user_form.id).destroy_all
        Form.translate_form_schema(user_form.schema, user_form.id, "USER_FORMS", user_form.form.form_type, user_form.form_name)
      end
      RecommendationForm.includes(:recommendation_record).where(:recommendation_records => {:procedure_id => procedure_ids}).each do |recommendation_form|
        FormInput.where(:form_id => recommendation_form.id).destroy_all
        Form.translate_form_schema(recommendation_form.schema, recommendation_form.id, "RECOMMENDATION_FORMS", recommendation_form.recommendation_record.form_template.form_type, recommendation_form.form_name)
      end
      InterviewEvaluateForm.includes(:interview_evaluate => :form).where(:forms => {:procedure_id => procedure_ids}).each do |interview_evaluate_form|
        FormInput.where(:form_id => interview_evaluate_form.id).destroy_all
        Form.translate_form_schema(interview_evaluate_form.schema, interview_evaluate_form.id, "INTERVIEW_EVALUATE_FORMS", interview_evaluate_form.interview_evaluate.form.form_type, interview_evaluate_form.interview_evaluate.form.form_name)
      end
      render :json => {:success => true, :msg => "The form schema has been exported successfully."}
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      render :json => {:success => false, :msg => "Failed to export the form schema."}
    end
  end

  def delete_zip_files
    FileUtils.cd("./public/saas/app/uploads/zip/") do
      Dir.glob("*.zip") do |file|
        #logger.info "== #{file} #{File.ctime(file)} =="
        past_time = Time.now() - File.ctime(file)
        if past_time > 3600
          logger.info "== #{Time.now()} delete #{file}=="
          File.delete file
        end
      end
    end
    render :text => "complete"
  end

  def clear_garbage
    GC.start
    logger.info "============================================================="
    logger.info "** Clear the data no needs.                                **"
    logger.info "============================================================="
    render :text => "success"
  end

  def get_applicant_user_rd_records
    ssl_client_cert = nil;
    ssl_client_key = nil;

    f_crt = File.read(SSL_CRT_PATH)
    f_key = File.read(SSL_KEY_PATH)

    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/cases/queries.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/cases/queries.json?c=22222-111&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
    end

    client = RestClient::Resource.new(
      api_url,
      :ssl_client_cert  =>  ssl_client_cert,
      :ssl_client_key   =>  ssl_client_key,
      :verify_ssl       =>  false
    );

    user_suid_string = User.where.not(:suid => nil).pluck(:suid).join(",") # Take all the user suid into a string split by ','
    all_the_cases = JSON.parse(client.post({:studentId => user_suid_string})) # API call and get the datas about case

    rd_records_with_user_data = RdRecord.includes(:user).all # Get the user suid in RdRecord table
    rd_records_with_suid = rd_records_with_user_data.as_json(
      :include => {
        :user => {
          :only => [:suid]
        }
      }
    )
    rd_records_with_suid.each do |rd_record| # Clear the case was cancled
      remote_data_exist = all_the_cases.any?{|a| (a["caseId"] == rd_record["case_id"]) && (a["involvedStudentId"].include? rd_record["user"]["suid"])}
      RdRecord.find_by_id(rd_record["id"]).destroy if !remote_data_exist
    end

    all_the_cases.each do |single_case|
      case_involved_student_ids = single_case["involvedStudentId"].split("; ") # Involve student(s) in each case product an array
      case_involved_student_ids.each do |involved_student_id| # Involve student(s) in each case check..
        involve_user = User.where(:suid => involved_student_id).first # Find the user with the suid the same as involved student id
        if involve_user # If the user existed..
          existed_record = RdRecord.where(:user_id => involve_user.id, :case_id => single_case["caseId"]).first # Find the rd record about user with this case
          existed_record.update_attributes(
            :primary_student_id => single_case["primaryStudentId"],
            :primary_student_name => single_case["primaryStudentName"],
            :involved_student_id => single_case["involvedStudentId"],
            :involved_student_name => single_case["involvedStudentName"],
            :case_type => single_case["caseType"],
            :created_date => single_case["createdDate"]
          ) if existed_record # If the record in db, update
          RdRecord.create(
            :user_id => involve_user.id,
            :case_id => single_case["caseId"],
            :primary_student_id => single_case["primaryStudentId"],
            :primary_student_name => single_case["primaryStudentName"],
            :involved_student_id => single_case["involvedStudentId"],
            :involved_student_name => single_case["involvedStudentName"],
            :case_type => single_case["caseType"],
            :created_date => single_case["createdDate"]
          ) if !existed_record # If the record not in db, create
        end # If the user not existed, nothing to do
      end
    end

    render :text => "success"
  end

  def get_applicant_user_rd_records_ver0
    ssl_client_cert = nil;
    ssl_client_key = nil;

    f_crt = File.read(SSL_CRT_PATH)
    f_key = File.read(SSL_KEY_PATH)

    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/cases/queries.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/cases/queries.json?c=22222-111&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
    end

    client = RestClient::Resource.new(
      api_url,
      :ssl_client_cert  =>  ssl_client_cert,
      :ssl_client_key   =>  ssl_client_key,
      :verify_ssl       =>  false
    );

    User.all.each do |user| # change to User
      if user.suid
        single_applicant_ill_recs = client.post({:studentId => user.suid})
        ill_rec = JSON.parse(single_applicant_ill_recs)

        ill_rec_case_ids = [] # ill_rec.collect{|obj| obj["caseId"]}

        ill_rec.each do |single_ill_rec|
          exist_record = RdRecord.where(:user_id => user.id, :case_id => single_ill_rec["caseId"]).first
          RdRecord.create(
            :user_id => user.id,
            :case_id => single_ill_rec["caseId"],
            :primary_student_id => single_ill_rec["primaryStudentId"],
            :primary_student_name => single_ill_rec["primaryStudentName"],
            :involved_student_id => single_ill_rec["involvedStudentId"],
            :involved_student_name => single_ill_rec["involvedStudentName"],
            :case_type => single_ill_rec["caseType"],
            :created_date => single_ill_rec["createdDate"]
          ) if !exist_record
          exist_record.update_attributes(
            :primary_student_id => single_ill_rec["primaryStudentId"],
            :primary_student_name => single_ill_rec["primaryStudentName"],
            :involved_student_id => single_ill_rec["involvedStudentId"],
            :involved_student_name => single_ill_rec["involvedStudentName"],
            :case_type => single_ill_rec["caseType"],
            :created_date => single_ill_rec["createdDate"]
          ) if exist_record
          ill_rec_case_ids << single_ill_rec["caseId"]
        end
#=begin
        logger.info "== suid ================================================"
        logger.info user.suid
        logger.info "== illegal record ======================================"
        logger.info ill_rec
        logger.info "== illegal record case ids ============================="
        logger.info ill_rec_case_ids
        logger.info "========================================================"
#=end
        RdRecord.where(:user_id => user.id).where.not(:case_id => ill_rec_case_ids).delete_all
      end
    end

    render :text => "success"
  end

end
