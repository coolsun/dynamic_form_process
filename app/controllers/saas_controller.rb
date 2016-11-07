class SaasController < ApplicationController

  def send_question
    procedure = Procedure.find_by_id(params[:current_process_id])
    if procedure && procedure.contact_email.present?
      mail_to = procedure.contact_email
    else
      mail_to = 'selection@lists.stanford.edu'
    end

    title = "The user #{params[:contact][:name]} has a question, reply to #{params[:contact][:email]}"
    content = params[:contact][:message]

    if StanfordMailer.send_shipped(mail_to, title, content)
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end

  def repair_running_email_template
    all_type_list = [
      "interview_applicant_cancel_schedule_to_self",
      "interview_applicant_schedule_to_self",
      "interview_interviewer_cancel_schedule_to_self",
      "interview_interviewer_schedule_to_self",
      "interview_mgr_cancel_schedule_applicant",
      "interview_mgr_cancel_schedule_interviewer",
      "interview_mgr_cancel_select_applicant",
      "interview_mgr_cancel_select_interviewer",
      "interview_mgr_schedule_applicant",
      "interview_mgr_schedule_interviewer",
      "interview_mgr_select_applicant",
      "interview_mgr_select_interviewer",
      "invite_recommender",
      "notice_applicant_get",
      "notice_applicant_send",
      "notice_recommender_submit",
      "offer_email",
      "post_match_invitation",
      "remind_recommender",
      "submission_application",
      "withdraw_application",
      "applicants_submit_ranked_list",
      "location_managers_submit_ranked_list",
      "offer_confirm_notice_email"
    ]
    repairs = []
    Procedure.all.order("id asc").each do |process|
      logger.info("The process id now is : #{process.id}")

      all_type_list.each do |type|
        template_in_process_with_type = EmailTemplate.where(:procedure_id => process.id, :email_type => type, :is_active => true).order(:updated_at => :desc)

        if template_in_process_with_type.count == 0
          get_default_template = EmailTemplate.where(:procedure_id => 0, :email_type => type).first
          repair = EmailTemplate.create(
            :title => get_default_template.title,
            :content => get_default_template.content,
            :email_type => get_default_template.email_type,
            :procedure_id => process.id,
            :is_active => true
          )
          repairs << repair
        elsif template_in_process_with_type.count > 1
          template_in_process_with_type.each do |template|
            template.update_attributes(:is_active => false)
          end
          repair = template_in_process_with_type.first.update_attributes(:is_active => true)
          repairs << repair
        end
      end
    end

    render :json => {:repairs => repairs}
  end

end