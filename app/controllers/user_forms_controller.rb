class UserFormsController < ApplicationController

  def show
    @user_form = UserForm.find_by_id(params[:id])
    @user_form.schema = Form.data_binding(@user_form.schema, @user_form.user_id, session[:user_id])

    if @user_form
      render :json => {:success => true, :form => @user_form.as_json(:include => [:upload_files])}
    else
      render :json => {:success => false}
    end
  end

  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Fill In Form")
    is_success = false
    msg = ""
    if permission_to_active || applicant_submit = Applicant.is_application_sumbit(session[:user_id], params[:current_process_id])
      @user_form = UserForm.find_by_id(params[:id])
      user = User.find_by_id(@user_form.user_id)
      logger.info "== params[:is_submit] #{params[:is_submit]} =="
      @user_form.submit_date = Time.now if params[:is_submit]
      if @user_form.update(user_form_update_params)
        is_success = true
        msg = "The form has been updated successfully."
        if @user_form.form.form_type == "System"
          @user_form.schema = Form.data_binding(@user_form.schema, user.id, session[:user_id])
          @user_form.save!
        end
      else
        msg = "There was a problem to update the form."
      end
    else
      msg = permission_message
    end
    render :json => {:success => is_success, :msg => msg}
  end

  def show_user_filled_forms
    if params[:sub_step] == "fill_in_form"
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Fill In Form")
      permission_to_active = permission_to_active & !(Applicant.is_application_sumbit(session[:user_id], params[:current_process_id]))
    else
      permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Post Match Fill In Form")
    end
    user = User.find_by_id(session[:user_id])
    procedure_id = params[:current_process_id]
    if user
      @filled_forms = []
      system_forms = Form.where({:procedure_id => procedure_id, :display => true, :form_type => "System"}).order("rank")
      forms = system_forms + Form.get_attachable_forms(procedure_id, user.id)
      forms.each do |form|
        filled_form = UserForm.where(:user_id => user.id, :form_id => form.id).first
        if !filled_form
          filled_form = UserForm.new
          filled_form.user_id = user.id
          filled_form.form_id = form.id
          filled_form.procedure_id = procedure_id
          filled_form.form_name = form.form_name
          filled_form.schema = form.schema
        end
        logger.info "== form.id #{form.id} data_binding go =="
        filled_form.schema = Form.data_binding(filled_form.schema, filled_form.user_id, session[:user_id])
        filled_form.save!
        @filled_forms << filled_form
      end
    end
    logger.info "== #{@filled_forms.to_json} =="
    render :json => {:forms => @filled_forms.as_json(:include => [:upload_files]), :permission_to_active => permission_to_active}
  end

  def applicant_forms
    permission_to_show, permission_to_active, permission_message = check_user_permission("Show Applicant All Form")
    system_form = UserForm.where(:id => params[:system])
    system_form.each do |form|
      form.schema = Form.data_binding(form.schema, form.user_id, session[:user_id])
    end
    application_form = UserForm.where(:id => params[:application])
    recommendation_form = []
    RecommendationForm.where(:id => params[:recommendation]).all.each do |form|
      recommendation_form << RecommendationForm.schema_add_name_relationship(form)
    end
    interview_form = InterviewEvaluateForm.where(:id => params[:interview])
    transcripts = []
    transcripts = Transcript.applicant_transcripts(params[:transcripts]) if User.find_by_id(session[:user_id]).is_staff
    forms = (system_form + application_form + recommendation_form + interview_form)
    if forms
      render :json => {:success => true, :forms => forms.as_json(:include => [:upload_files]), :transcripts => transcripts}
    else
      render :json => {:success => false}
    end
  end

  def delete_user_forms
    delete_forms_id = params[:id_array]
    delete_forms_id.each do |delete_id|
      delete_user_form = UserForm.find_by_id(delete_id)
      delete_user_form.destroy
    end
    render :nothing => true
  end

  def form_translations
    form_translations = FormTranslation.select(:translate_key, :description).all
    if form_translations
      render :json => {:success => true, :form_translations => form_translations}
    else
      render :json => {:success => false}
    end
  end

  private

  def user_form_update_params
    params.require(:user_form).permit(:schema)
  end

end
