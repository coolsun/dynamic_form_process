class StanfordMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: 'no-reply-selection@stanford.edu'
  elsif STANFORD68
    default from: 'no-reply-resjob@saisappdev68.stanford.edu'
  else
    default from: 'Stanford Email Send Test'
  end

  def self.send_shipped(email, title, message, bcc=[], cc=[], reply_to = '')
    success = false;

    begin
      email = [email] if !email.kind_of?(Array)
      email.each do |mail|
        StanfordMailer.shipped(mail, title, message, bcc, cc, reply_to).deliver;
      end
      success = true;
    rescue => e
      logger.error "e.message : #{e.message}";
      logger.error "e.backtrace : #{e.backtrace}";
      success = false;
    end

    return success;
  end

  def shipped(email, title, message, bcc=[], cc=[], reply_to = '')
    @greeting = message
    logger.info("== bcc #{bcc} ==")
    if (reply_to.present?)
      logger.info("reply_to: #{reply_to}");
      mail(:to => mail_confirm(email), :cc => mail_confirm(cc), :bcc => mail_confirm(ADMIN_MAIL + bcc), :subject => title, :reply_to => reply_to)
    else
      mail(:to => mail_confirm(email), :cc => mail_confirm(cc), :bcc => mail_confirm(ADMIN_MAIL + bcc), :subject => title)
    end

  end

  def send_admin(title,message)
    @message = message

    mail(:to => ADMIN_MAIL, :subject => title)
  end

  def mail_confirm(emails)
    emails = [emails] if !emails.kind_of?(Array)
    return emails.select{|mail| mail.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)}
  end

end
