class InterviewEvaluatesController < ApplicationController

  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_review")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    is_success = false
    msg = ""
    permission_to_show, permission_to_active, permission_message = true, true, true #check_user_permission("Update Evaluate")
    if permission_to_active
      @interview_evaluate_form = InterviewEvaluateForm.find_by_id(params[:id])
      #logger.info "== @interview_evaluate_form #{@interview_evaluate_form.to_json} =="
      if @interview_evaluate_form.update(form_update_params)
        is_success = true
        msg = "The form has been updated successfully."
      else
        msg = "There was a problem to update the form."
      end
    else
      msg = permission_message
    end
    render :json => {:success => is_success, :msg => msg}
  end

  def show_evaluate_forms
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_review")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    interviewer = User.find_by_id(session[:user_id])
    interviewee = User.find_by_id(params[:interviewee_id]) if params[:interviewee_id]
    procedure = Procedure.find_by_id(params[:current_process_id]) if params[:current_process_id]
    interview = Interview.find_by_id(params[:interview_id]) if params[:interview_id]

    if interviewee && interviewer && interview

      @interview_evaluate_forms = []
      forms = Form.where(:procedure_id => procedure.id, :display => true, :form_type => "Interview").order(:rank)
      forms.each do |form|
        interview_evaluate = InterviewEvaluate.includes(:interview_evaluate_form).where(:interview_id => interview.id, :interviewee_user_id => interviewee.id, :judge_interviewer_user_id => interviewer.id, :form_id => form.id).first
        interview_evaluate_form = ""
        if !interview_evaluate
          interview_evaluate = InterviewEvaluate.new
          interview_evaluate.judge_interviewer_user_id = interviewer.id
          interview_evaluate.interviewee_user_id = interviewee.id
          interview_evaluate.form_id = form.id
          interview_evaluate.interview_id = interview.id
          interview_evaluate.save!
          interview_evaluate_form = InterviewEvaluateForm.new
          interview_evaluate_form.interview_evaluate_id = interview_evaluate.id
          interview_evaluate_form.schema = Form.data_binding(form.schema, interviewee.id, session[:user_id])
          interview_evaluate_form.save!
        else
          if interview_evaluate.interview_evaluate_form
            interview_evaluate_form = interview_evaluate.interview_evaluate_form
          else
            interview_evaluate_form = InterviewEvaluateForm.new
            interview_evaluate_form.interview_evaluate_id = interview_evaluate.id
            interview_evaluate_form.schema = Form.data_binding(form.schema, interviewee.id, session[:user_id])
            interview_evaluate_form.save!
          end
        end
        @interview_evaluate_forms << interview_evaluate_form
      end
    end
    #logger.info "== #{@interview_evaluate_forms.to_json} =="
    render :json => {:forms => @interview_evaluate_forms, :permission_to_active => true} #permission_to_active}
  end


  def show_review_forms
    permission_to_show, permission_to_active, permission_message = check_user_permission("interview_review")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    interviewee = User.find_by_id(params[:interviewee_id]) if params[:interviewee_id]
    procedure = Procedure.find_by_id(params[:current_process_id]) if params[:current_process_id]
    interview = Interview.find_by_id(params[:interview_id]) if params[:interview_id]

    if interviewee && interview
      @interview_evaluate_forms = []
      forms = Form.where(:procedure_id => procedure.id, :display => true, :form_type => "Interview").order(:rank)
      forms.each do |form|
        interview_evaluates = InterviewEvaluate.includes(:interview_evaluate_form, :reviewer).where(:interview_id => interview.id, :interviewee_user_id => interviewee.id, :form_id => form.id).order(:id);

        if (interview_evaluates)
          interview_evaluates.each do |evaluate|
            if evaluate.interview_evaluate_form
              interview_evaluate_form = evaluate.interview_evaluate_form.as_json();
              interview_evaluate_form["reviewer"] = evaluate.reviewer.as_json({
                :methods => :name
              });
              @interview_evaluate_forms << interview_evaluate_form
            end
          end
        end
      end
    end
    #logger.info "== #{@interview_evaluate_forms.to_json} =="
    render :json => {:forms => @interview_evaluate_forms, :permission_to_active => true} #permission_to_active}
  end





  private

  def form_update_params
    params.require(:interview_evaluate).permit(:schema)
  end

end
