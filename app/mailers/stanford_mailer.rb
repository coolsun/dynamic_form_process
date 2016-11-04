class StanfordMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: 'no-reply-selection@stanford.edu'
  elsif STANFORD68
    default from: 'no-reply-resjob@saisappdev68.stanford.edu'
  else
    default from: 'Stanford Email Send Test'
  end

  def self.send_shipped(email, title, message, bcc=[], cc=[], reply_to = '', mgr_rank_list = '', user_rank_list = '')
    success = false;

    begin
      email = [email] if !email.kind_of?(Array)
      email.each do |mail|
        StanfordMailer.shipped(mail, title, message, bcc, cc, reply_to, mgr_rank_list, user_rank_list).deliver;
      end
      success = true;
    rescue => e
      logger.error "e.message : #{e.message}";
      logger.error "e.backtrace : #{e.backtrace}";
      success = false;
    end

    return success;
  end

  def shipped(email, title, message, bcc=[], cc=[], reply_to = '', mgr_rank_list = '', user_rank_list = '')
    @greeting = message
    logger.info("== bcc #{bcc} ==")
    logger.info("== mgr rank list: #{mgr_rank_list} ==")
    logger.info("== user rank list: #{user_rank_list} ==")

    if mgr_rank_list.present? || user_rank_list.present?
      @rank_list = mgr_rank_list.present? ? mgr_rank_list : user_rank_list
      @type = mgr_rank_list.present? ? "mgr" : "user"
      xlsx = render_to_string handlers: [:axlsx], formats: [:xlsx], template: "reports/rank_list_report", locals: {:@rank_list => @rank_list, :@type => @type}, layout: false
      attachments["Rank List.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}
    end

    if (reply_to.present?)
      logger.info("reply_to: #{reply_to}");
      mail(:to => mail_confirm(email), :cc => mail_confirm(cc), :bcc => mail_confirm(ADMIN_MAIL + bcc), :subject => title, :reply_to => reply_to)
    else
      mail(:to => mail_confirm(email), :cc => mail_confirm(cc), :bcc => mail_confirm(ADMIN_MAIL + bcc), :subject => title)
    end

  end

  def send_rank_email(email, title, message, bcc=[], cc=[], ranking_list)
    @greeting = message

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
