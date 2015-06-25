# Preview all emails at http://localhost:3000/rails/mailers/stanford_mailer
class StanfordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/stanford_mailer/shipped
  def shipped
    StanfordMailer.shipped
  end

end
