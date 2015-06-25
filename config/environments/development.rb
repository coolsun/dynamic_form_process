Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true # default: false in development. (#kimi YUXING LEE)

  # Add on 2014-07-11 for test email template

  config.action_mailer.delivery_method = :smtp
  STANFORD68 = false

  if STANFORD68
    config.action_mailer.smtp_settings = {
      address: "localhost",
      port: 25,
      enable_starttls_auto: true  }
  else
=begin
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 25,
      domain: "localhost",
      user_name: "trillion5566@gmail.com",
      password: "5566trillion",
      authentication: 'plain',
      enable_starttls_auto: true
    }
=end
    email_smtp_setting = 1;

    case email_smtp_setting
    when 1
      config.action_mailer.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 25,
        :domain => "localhost",
        :user_name => "trillion5566@gmail.com",
        :password => "trillion55667788",
        :authentication => 'plain',
        :enable_starttls_auto => true
      }
    when 2
      config.action_mailer.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 25,
        :domain => "localhost",
        :user_name => "test96023@gmail.com",
        :password => "1qazxcvfrtyujm",
        :authentication => 'plain',
        :enable_starttls_auto => true
      }
    end

  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  ADMIN_MAIL = [
    "hank@trillioninnovations.com",
    "peter@trillioninnovations.com",
    "kimi@trillioninnovations.com",
    "carol@trillioninnovations.com"
  ]


  if STANFORD68
    HOST_URL = 'http://saisappdev68.stanford.edu';
    HOST_SSL_URL = 'https://saisappdev68.stanford.edu';
  else
    HOST_URL = 'http://184.169.165.135:8010';
    HOST_SSL_URL = 'http://184.169.165.135:8010';
  end

  SSL_PATH = Rails.root + "lib/ssl_key/";

  SSL_CRT_PATH = SSL_PATH + "saisappdev68.crt";
  SSL_KEY_PATH = SSL_PATH + "saisappdev68.key";
  #SSL_P12_PATH = '';

end
