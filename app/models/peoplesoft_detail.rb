class PeoplesoftDetail < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  def self.get_people_soft(sunet_id) # sunet_id = webauth_id = remote_user
=begin
    f_crt = File.read(SSL_PATH + "saisappdev68.crt")
    f_key = File.read(SSL_PATH + "saisappdev68.key")
    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/students/#{sunet_id}/profile.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=bsun2"
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/students/#{sunet_id}/profile.json?c=22222-111&requesterId=bsun2"
    end

    client = RestClient::Resource.new(
      #'https://saisappdev96.stanford.edu/saservice2/v2.0/students/ewoodson/profile.json?c=22222-111&requesterId=bsun2',
      api_url,
      :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(f_crt),
      :ssl_client_key   =>  OpenSSL::PKey::RSA.new(f_key),
      :verify_ssl       =>  false
    );
=end

    client = nil;
    ssl_client_cert = nil;
    ssl_client_key = nil;

    f_crt = File.read(SSL_CRT_PATH)
    f_key = File.read(SSL_KEY_PATH)

    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/students/#{sunet_id}/profile.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=#{sunet_id}"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/students/#{sunet_id}/profile.json?c=22222-111&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
    end

    client = RestClient::Resource.new(
      api_url,
      :ssl_client_cert  =>  ssl_client_cert,
      :ssl_client_key   =>  ssl_client_key,
      :verify_ssl       =>  false
    );

    return (client);
  end

end
