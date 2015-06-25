class MailController < ApplicationController

  def user_mail_list
    user_mail_list = []
    User.all.each do |user|
      if user
        user_mail_list << {"id" => user.id, "name" => user.name, "email" => user.email}
      end
    end
    render :json => {:select_list => [], :all => user_mail_list}
  end

  def send_mail
    if params[:to].present?
      new_title = params[:title]
      new_content = params[:content]

      process = Procedure.find_by_id(params[:process_id]) if params[:process_id]
      if process
        new_title = new_title.sub('[[ProcessName]]', process.name)
        new_content = new_content.sub('[[ProcessName]]', process.name)
      end
      position = Position.find_by_id(params[:position_id]) if params[:position_id]
      if position
        new_title = new_title.sub('[[ProcessName]]', position.name)
        new_content = new_content.sub('[[ProcessName]]', position.name)
      end
      #new_title = new_title.sub('[[FirstName]]', params[:recommendation_record][:name])
      #new_content = new_content.sub('[[FirstName]]', params[:recommendation_record][:name])
      #new_content = new_content.sub('[[RecommendationForm]]', '<a href="' + url + '">Go to recommend</a>')
      new_content = new_content.sub('[[DateNow]]', Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M"))

      params[:to].each do |search_user|
        #search_user = JSON.parse(search_user)
        user = User.find_by_id(search_user["id"])
        if (user && user.email || !user && /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/.match(search_user.email))
          use_title = new_title.sub('[[Applicant]]', user.name)
          use_content = new_content.sub('[[Applicant]]', user.name)

          logger.info "== emails #{user.email} =="
          logger.info "== new_title #{use_title} =="
          logger.info "== new_content #{use_content} =="
          #StanfordMailer.send_shipped(user.email, use_title, use_content)
        end
      end
    end
    render :text =>"success"
  end

end
