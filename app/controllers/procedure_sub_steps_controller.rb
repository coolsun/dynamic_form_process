class ProcedureSubStepsController < ApplicationController

  def update
    @process_sub_step = ProcedureSubStep.find_by_id(params[:id])

    if @process_sub_step.id && @process_sub_step.update(update_procedure_sub_step_params)
      render :json => {"success" => true}
    else
      render :json => {"success" => false, "messages" => @process_sub_step.errors}
    end
  end

  def update_sub_steps_time
    is_success = false
    step_time = params[:step_time]
    sub_steps_time = params[:sub_steps_time]

    step = ProcedureStep.find_by_id(step_time[:id])
    permission_to_show, permission_to_active, permission_message = check_user_permission(step.name)
    if permission_to_active
      step.t_start_string = step_time[:t_start_string]
      step.t_end_string = step_time[:t_end_string]
      step.save
      is_success = true
    end

    if sub_steps_time.present?
      sub_steps_time.each do |sub_step_time|
        sub_step = ProcedureSubStep.find_by_id(sub_step_time[:id])

        if step.name == "Interview" || (step.name == "Post Match" && sub_step.name == 'Post Match Interview')
          permission_to_show, permission_to_active, permission_message = check_user_permission("interview")
        else
          permission_to_show, permission_to_active, permission_message = check_user_permission(sub_step.identify_name)
        end
        if permission_to_active
          sub_step.t_start_string = sub_step_time[:t_start_string].present? ? sub_step_time[:t_start_string] : step_time[:t_start_string]
          sub_step.t_end_string = sub_step_time[:t_end_string].present? ? sub_step_time[:t_end_string] : step_time[:t_end_string]
          sub_step.save
          is_success = true
        end
      end
    end



    if is_success
      render :json => {:success => true, :msg => "The time has been updated successfully."}
    else
      render :json => {:success => false, :msg => "The time has not been changed."}
    end
  end

  private

  def update_procedure_sub_step_params
    params.require(:procedure_sub_step).permit(:enabled, :rank)
  end

end
