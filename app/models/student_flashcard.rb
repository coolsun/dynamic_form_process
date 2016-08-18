class StudentFlashcard < ActiveRecord::Base

  def self.get_student_flashcard_data(suid, sunet_id)
    json_message = nil;
    if (suid.present?)

      client = nil;
      ssl_client_cert = nil;
      ssl_client_key = nil;

      f_crt = File.read(SSL_CRT_PATH)
      f_key = File.read(SSL_KEY_PATH)

      if Rails.env == "production"
        #api_url = "https://saisapp96.stanford.edu/saservice2/v3.0/students/#{suid}/profile.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=#{sunet_id}"

        #ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
        #ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
      else
        api_url = "https://saisappdev96.stanford.edu/saservice2/v3.0/students/#{suid}/profile?c=resjobs-111&requesterId=#{sunet_id}"

        ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
        ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
      end

      client = RestClient::Resource.new(
        api_url,
        :ssl_client_cert  =>  ssl_client_cert,
        :ssl_client_key   =>  ssl_client_key,
        :verify_ssl       =>  false
      );


      json_message = nil;
      begin
        message = client.get();
        json_message = JSON.parse(message);
      rescue => e
        error_msg = "# #{Time.now}, get_student_flashcard_data, suid: #{suid}, e.message : #{e.message}"
        logger.error(error_msg)

        json_message = {:error_msg => e.message};

        #StanfordMailer.send_admin("get_student_flashcard_data Fail", error_msg).deliver
      end
    end

    return (json_message);

  end



end
