class FilesController < ApplicationController

  # DELETE /files/1
  def destroy
    @file = UploadFile.find_by_id(params[:id])

    if @file.destroy
      #File.delete('./public/saas/app//uploads/' + @file.file_name)
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end

  def upload
    original_filename = params[:file].original_filename
    temp_path = params[:file].tempfile.path
    hex = SecureRandom.hex
    sunet_id = User.find_by_id(session[:user_id]).sunet_id

    upload_file = UploadFile.new(:original_filename => original_filename, :file_name => hex)
    if params[:user_form_id]
      upload_file.user_form_id = params[:user_form_id]
    elsif params[:interview_form_id]
      upload_file.interview_evaluate_form_id = params[:interview_form_id]
    elsif params[:recommendation_form_id]
      upload_file.recommendation_form_id = params[:recommendation_form_id]
    else
      render json: { success: false, message: 'Error upload.'}
    end
    upload_file.save!

    if upload_file = UploadFile.where(:file_name => hex).last
      file_name = upload_file.id.to_s + "_" + sunet_id + "_" + upload_file.original_filename
      upload_file.file_name = file_name
      year = Year.find_by_is_current_year(true)
      folder = "./public/saas/app/uploads/" + year.id.to_s + "/"
      if !(File.exist?(folder))
        FileUtils.mkdir folder
      end
      file_path = folder + file_name
      upload_file.file_path = file_path[8..-1]
      upload_file.save!
    end

    logger.info "=== uploadifye === cp " + temp_path + " to " + file_path
    FileUtils.cp temp_path, file_path
    FileUtils.chmod "u=wr,g=r", file_path

    render :json => "success", :status => :ok
  end

  def form_file_list
    if params[:type] == "Interview"
      @files = UploadFile.where(:interview_evaluate_form_id => params[:form_id])
    elsif params[:type] == "Recommender"
      @files = UploadFile.where(:recommendation_form_id => params[:form_id])
    else
      @files = UploadFile.where(:user_form_id => params[:form_id])
    end

    if @files
      render :json => {:success => true, :files => @files}
    else
      render :json => {:success => false}
    end
  end

  def download_forms_files
    if params[:selected_forms].present?
      hex = nil
      folder = nil
      JSON.parse(params[:selected_forms]).each do |applicant|
        user = User.find_by_id(applicant["user_id"])
        next if !user
        system_forms = (applicant["system"] + applicant["application"])
        recommendation_forms = applicant["recommendation"]
        interview_forms = applicant["interview"]
        logger.info "== #{system_forms} #{recommendation_forms} #{interview_forms} =="

        files_information = UploadFile.where("user_form_id in (?) or recommendation_form_id in (?) or interview_evaluate_form_id in (?)", system_forms, recommendation_forms, interview_forms)
        if files_information.present?
          folder = "./public/saas/app/uploads/zip/"
          if !(File.exist?(folder))
            FileUtils.mkdir folder
          end
          if !hex
            loop do
              hex = SecureRandom.hex
              folder = "./public/saas/app/uploads/zip/" + hex + "/"
              break if !(File.exist?(folder))
            end
            FileUtils.mkdir folder
          else
            folder = "./public/saas/app/uploads/zip/" + hex + "/"
          end
          applicant_folder = folder + user.id.to_s + "_" + user.sunet_id.to_s + "/"
          FileUtils.mkdir applicant_folder if !(File.exist?(applicant_folder))
        end
        files_information.each do |file_information|
          if file_information.user_form_id
            table_name = file_information.user_form.form_name
          elsif file_information.recommendation_form_id
            table_name = file_information.recommendation_form.form_name
          elsif file_information.interview_evaluate_form_id
            table_name = file_information.interview_evaluate.form.form_name
          else
            next
          end
          table_folder = applicant_folder + table_name + "/"
          FileUtils.mkdir table_folder if !(File.exist?(table_folder))
          FileUtils.cp "./public" + file_information.file_path, table_folder
        end
      end
      if hex
        FileUtils.cd("./public/saas/app/uploads/zip/") do
          system("zip -r #{hex} #{hex}")
          FileUtils.rm_rf hex
        end
      end
      render :json => {:success => true, :file_link => (hex.present? ? "/saas/app/uploads/zip/#{hex}.zip" : nil)}
    else
      render :json => {:success => false}
    end
  end

end