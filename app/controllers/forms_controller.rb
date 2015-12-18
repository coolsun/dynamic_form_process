class FormsController < ApplicationController

  def show_process_forms
    if params[:identify_name].present?
      permission_to_show, permission_to_active, permission_message = check_user_permission(params[:identify_name])
      render :json => {:success => false, :msg => permission_message} and return if !permission_to_show
    else
      permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Global")
      render :json => {:success => false, :msg => permission_message} and return if !permission_to_show
    end

    # Get the forms in process, in sub step
    forms = Form.get_form_list(params[:process_id], params[:identify_name])
    if !is_admin && !is_hiring_mgr(params[:process_id]) && !is_procedure_role_mgr(params[:process_id]) && is_procedure_location_mgr(params[:process_id])
      forms = filter_location_form(forms, params[:process_id], current_user.id)
    end

    roles_in_process = []
    locations_in_process = []
    positions_in_process = []

    if params[:identify_name] == "set_up_attachable_forms" || params[:identify_name] == "post_offer_fill_in_form"
      if is_admin || is_hiring_mgr(params[:process_id])
        roles_in_process = Role.where(:procedure_id => params[:process_id]).select(:id, :name, :tag)
        locations_in_process = Location.where(:procedure_id => params[:process_id]).select(:id, :name, :tag)
        positions_in_process = Position.where(:procedure_id => params[:process_id]).as_json(only: [:id], methods: :name)
      else
        positions_in_process_r = []
        positions_in_process_l = []
        if is_procedure_role_mgr(params[:process_id])
          role_ids = RoleMgr.where(:user_id => current_user.id).pluck(:role_id)
          roles_in_process = Role.where(:id => role_ids, :procedure_id => params[:process_id]).select(:id, :name, :tag)
          positions_in_process_r = Position.where(:procedure_id => params[:process_id], :role_id => role_ids).as_json(only: [:id], methods: :name)
        end
        if is_procedure_location_mgr(params[:process_id])
          location_ids = LocationMgr.where(:user_id => current_user.id).pluck(:location_id)
          locations_in_process = Location.where(:id => location_ids, :procedure_id => params[:process_id]).select(:id, :name, :tag)
          positions_in_process_l = Position.where(:procedure_id => params[:process_id], :location_id => location_ids).as_json(only: [:id], methods: :name)
        end
        positions_in_process = positions_in_process_r | positions_in_process_l
      end
    end
    all_tags = {:roles => roles_in_process, :locations => locations_in_process, :positions => positions_in_process}

    render :json => {:success => true, :permission_to_active => permission_to_active, :forms => forms, :all_tag_sets => all_tags}
  end

  def save_new_form
    permission_to_show, permission_to_active, permission_message = check_user_permission(params[:identify_name])
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    if params[:form_name].present?
      the_created_form = Form.create(
        :procedure_id => params[:process_id],
        :form_type => Form.get_form_type(params[:identify_name]),
        :form_name => params[:form_name],
        :display => params[:display],
        :html => params[:form],
        :schema => params[:schema].to_json.to_s,
        :rank => Form.where({:procedure_id => params[:process_id], :form_type => Form.get_form_type(params[:identify_name])}).length + 1
      )
      if params[:identify_name] == "set_up_attachable_forms" || params[:identify_name] == "post_offer_fill_in_form"
        if params[:tag_type] == "" || (params[:selected][:roles].nil? && params[:selected][:locations].nil? && params[:selected][:positions].nil?)
          FormTag.create(:form_id => the_created_form.id)
        else
          if params[:selected][:roles].present?
            params[:selected][:roles].each do |new_role_tag|
              FormTag.create(:form_id => the_created_form.id, :role_id => new_role_tag[:id])
            end
          end
          if params[:selected][:locations].present?
            params[:selected][:locations].each do |new_location_tag|
              FormTag.create(:form_id => the_created_form.id, :location_id => new_location_tag[:id])
            end
          end
          if params[:selected][:positions].present?
            params[:selected][:positions].each do |new_position_tag|
              FormTag.create(:form_id => the_created_form.id, :position_id => new_position_tag[:id])
            end
          end
        end
      end

      forms = Form.get_form_list(params[:process_id], params[:identify_name])
      if !is_admin && !is_hiring_mgr(params[:process_id]) && !is_procedure_role_mgr(params[:process_id]) && is_procedure_location_mgr(params[:process_id])
        forms = filter_location_form(forms, params[:process_id], current_user.id)
      end

      render :json => {:success => true, :forms => forms}
    end
  end

  def edit_old_form
    if params[:identify_name].present?
      permission_to_show, permission_to_active, permission_message = check_user_permission(params[:identify_name])
      render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    else
      permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Global")
      render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    end

    if params[:form_name].present?
      update_form = Form.find_by_id(params[:id])
      update_form.update_attributes(
        :form_name => params[:form_name],
        :html => params[:form],
        :schema => params[:schema].to_json.to_s
      )

      all_tags = FormTag.where(:form_id => params[:id])
      all_tags.destroy_all

      if params[:identify_name] == "set_up_attachable_forms" || params[:identify_name] == "post_offer_fill_in_form"
        if params[:tag_type] == "" || (params[:selected][:roles].nil? && params[:selected][:locations].nil? && params[:selected][:positions].nil?)
          FormTag.create(:form_id => params[:id])
        else
          if params[:selected][:roles].present?
            params[:selected][:roles].each do |new_role_tag|
              FormTag.create(:form_id => params[:id], :role_id => new_role_tag[:id])
            end
          end
          if params[:selected][:locations].present?
            params[:selected][:locations].each do |new_location_tag|
              FormTag.create(:form_id => params[:id], :location_id => new_location_tag[:id])
            end
          end
          if params[:selected][:positions].present?
            params[:selected][:positions].each do |new_position_tag|
              FormTag.create(:form_id => params[:id], :position_id => new_position_tag[:id])
            end
          end
        end
      end

      forms = Form.get_form_list(params[:process_id], params[:identify_name])
      if !is_admin && !is_hiring_mgr(params[:process_id]) && !is_procedure_role_mgr(params[:process_id]) && is_procedure_location_mgr(params[:process_id])
        forms = filter_location_form(forms, params[:process_id], current_user.id)
      end

      render :json => {:success => true, :forms => forms}
    end
  end

  def delete_form
    permission_to_show, permission_to_active, permission_message = check_user_permission(params[:identify_name])
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    if params[:id].present?
      delete_form = Form.find_by_id(params[:id])
      delete_form.destroy

      forms = Form.get_form_list(params[:process_id], params[:identify_name])
      if !is_admin && !is_hiring_mgr(params[:process_id]) && !is_procedure_role_mgr(params[:process_id]) && is_procedure_location_mgr(params[:process_id])
        forms = filter_location_form(forms, params[:process_id], current_user.id)
      end

      render :json => {:success => true, :forms => forms}
    end
  end

  def toggle_show
    permission_to_show, permission_to_active, permission_message = check_user_permission(params[:identify_name])
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    if params[:id].present?
      toggle_form = Form.find_by_id(params[:id])
      toggle_form.update_attributes(:display => params[:display])
      forms = Form.get_form_list(params[:process_id], params[:identify_name])
      if !is_admin && !is_hiring_mgr(params[:process_id]) && !is_procedure_role_mgr(params[:process_id]) && is_procedure_location_mgr(params[:process_id])
        forms = filter_location_form(forms, params[:process_id], current_user.id)
      end

      render :json => {:success => true, :forms => forms}
    end
  end

  def get_application_form_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("fill_in_form")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    forms = Form.select(:id, :form_name, :display, :rank).where(:procedure_id => params[:current_process_id], :form_type => "Application", :display => true).order("rank asc")
    render :json => {:success => true, :forms => forms, :permission_to_active => permission_to_active}
  end

  def update_form_rank
    permission_to_show, permission_to_active, permission_message = check_user_permission("fill_in_form")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active
    begin
      msg = ""
      if params[:form_rank].kind_of?(Array)
        form_rank = {}
        params[:form_rank].each_with_index do |form_id, index|
          form_rank[form_id] = {:rank => index + 1}
        end
        Form.update(form_rank.keys, form_rank.values)
        msg = "The rank has been updated successfully."
      else
        msg = "No rank needs to be updated."
      end
      render :json => {:success => true, :msg => msg}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "There was a problem to update the rank."}
    end
  end

  def clone_form
    form = Form.find_by_id(params[:form_id])
    begin
      if form.present?
        new_form = Form.new
        new_form.procedure_id = form.procedure_id
        new_form.form_type = form.form_type
        new_form.form_name = form.form_name + " Copy"
        new_form.display = false
        new_form.rank = 999999
        new_form.html = form.html
        new_form.schema = form.schema
        new_form.save!
      end
      render :json => {:success => true, :form => new_form.as_json(:include => {:form_tags => {:only => [:role_id, :location_id, :position_id]}})}
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace
      render :json => {:success => false, :msg => "There was a problem to clone the form."}
    end
  end

  def filter_location_form(forms, process_id, current_user_id)
    location_ids = LocationMgr.where(:user_id => current_user_id).pluck(:location_id)
    position_ids = Position.where(:procedure_id => process_id, :location_id => location_ids).pluck(:id)
    location_forms = []
    forms.each do |form|
      if (form["form_tags"].select { |form_tag| (location_ids.include? form_tag["location_id"]) || 
                                                (position_ids.include? form_tag["position_id"])
                                   }
         ).present?
        location_forms << form
      end
    end
    return location_forms
  end

end
