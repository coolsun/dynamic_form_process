class Transcript < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  def grade_class
    return (self.subject + " " + self.no + ": " + self.title)
  end

  def self.applicant_transcripts(user_id)
    transcript = []
    Transcript.where(:user_id => user_id).each do |grade|
      transcript << {
        :term => grade.term,
        :career => grade.level,
        :grade_class => grade.grade_class,
        :grade => grade.grade,
        :unit => grade.unit,
      }
    end
    return transcript
  end

  def self.get_grades(user) # sunet_id = webauth_id = remote_user
    if user.last_transcript_date && Time.now() - user.last_transcript_date < 1.day
      return true
    end
    logger.info "================= get_grades #{user.sunet_id} ================="
    ssl_client_cert = nil;
    ssl_client_key = nil;

    f_crt = File.read(SSL_CRT_PATH)
    f_key = File.read(SSL_KEY_PATH)

    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/students/#{user.sunet_id}/grades?appId=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=#{user.sunet_id}"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/students/#{user.sunet_id}/grades?appId=22222-111&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
    end

    grades = RestClient::Resource.new(
      api_url,
      :ssl_client_cert  =>  ssl_client_cert,
      :ssl_client_key   =>  ssl_client_key,
      :verify_ssl       =>  false
    );

    msg = grades.get();
    logger.info "== xml_grades #{msg} =="
    json_msg = JSON.parse(Hash.from_xml(msg).to_json)
    logger.info "== json_msg #{json_msg} =="
    if !json_msg["error"] && json_msg["grades"] && json_msg["grades"]["quarters"]
      json_msg["grades"]["quarters"]["quarter"].each do |quarter|
        strmDescription = quarter["strmDescription"]
        array = [quarter["classes"]["class"]].flatten
        array.each do |grade_class|
          transcripts = self.where(:user_id => user.id, :term => strmDescription, :subject => grade_class["subject"]).first
          transcripts = self.new if transcripts.blank?
          transcripts.user_id = user.id
          transcripts.term = strmDescription
          transcripts.level = grade_class["academicCareer"]
          transcripts.subject = grade_class["subject"]
          transcripts.no = grade_class["catalogNbr"]
          transcripts.title = grade_class["courseTitle"]
          transcripts.grade = grade_class["officialGrade"]
          transcripts.unit = grade_class["unitEarned"].to_i
          transcripts.credit = grade_class["earnCredit"]
          transcripts.gpa = grade_class["includeInGPA"]
          transcripts.save
        end
      end
      user.last_transcript_date = Time.now()
      user.save
    end
  end

end
