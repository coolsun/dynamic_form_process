class EmailTemplatesController < ApplicationController

  def index
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    email_template = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => params[:email_type],
      :is_active => true).first # Get the template is using now
    email_template = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => params[:email_type]
    ).order(:updated_at => :desc).first if !email_template # If there is no template using, return a template whatever

    template_id_list = EmailTemplate.where(
      :procedure_id => params[:procedure_id],
      :email_type => params[:email_type]
    ).select(:id, :title, :is_active).order(:created_at => :asc) # Get new template list

    render :json => {:success => true, :permission_to_active => permission_to_active, :email_template => email_template, :template_id_list => template_id_list}
  end

  def show
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    email_template = EmailTemplate.find_by_id(params[:id]) # Get the selected template

    render :json => {:success => true, :email_template => email_template}
  end

  def create
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    check_same_template = EmailTemplate.where(
      :title => params[:email_template][:title],
      :procedure_id => params[:email_template][:procedure_id],
      :email_type => params[:email_template][:email_type],
    ).first # Get the existed template with the same title

    email_template = nil
    email_template = EmailTemplate.create(
      :title => params[:email_template][:title],
      :content => params[:email_template][:content],
      :procedure_id => params[:email_template][:procedure_id],
      :email_type => params[:email_template][:email_type],
      :is_active => params[:email_template][:is_active]
    ) if check_same_template.nil? # If no existed template, create a new template

    template_id_list = EmailTemplate.where(
      :procedure_id => params[:email_template][:procedure_id],
      :email_type => params[:email_template][:email_type]
    ).select(:id, :title, :is_active).order(:created_at => :asc) # Get new template list

    if !email_template.nil? # If creating a new template
      render :json => {:success => true, :email_template => email_template, :template_id_list => template_id_list}
    else # Else if it doesn't create one because the same title
      render :json => {:success => false, :msg => "This title has been used. Please try another title.", :template_id_list => template_id_list}
    end
  end

  def update
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    check_same_template = EmailTemplate.where(
      :title => params[:email_template][:title],
      :procedure_id => params[:email_template][:procedure_id],
      :email_type => params[:email_template][:email_type],
    )
    .where.not(
      :id => params[:email_template][:id]
    ).first # Get the existed template with the same title, except itself

    email_template = EmailTemplate.find_by_id(params[:id]) # Get the selected template
    email_template.update(email_template_params) if check_same_template.nil? # If no existed template, update the selected template

    template_id_list = EmailTemplate.where(
      :procedure_id => params[:email_template][:procedure_id],
      :email_type => params[:email_template][:email_type]
    ).select(:id, :title, :is_active).order(:created_at => :asc) # Get new template list

    if check_same_template.nil? # If there is no existed template
      render :json => {:success => true, :email_template => email_template, :template_id_list => template_id_list}
    else # Else if it doesn't update because the same title
      render :json => {:success => false, :msg => "This title has been used. Please try another title.", :template_id_list => template_id_list}
    end
  end

  def destroy
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    email_template = EmailTemplate.find_by_id(params[:id]) # Get the selected template
    email_template.destroy if !email_template.is_active # Delete this template if it's not using now

    template_id_list = EmailTemplate.where(
      :procedure_id => params[:current_process_id],
      :email_type => params[:email_type]
    ).select(:id, :title, :is_active).order(:created_at => :asc) # Get the selected template

    render :json => {:success => true, :template_id_list => template_id_list}
  end

  def use_it
    # Check permission
    if params[:current_process_id] == "0"
      permission_option = "Menu Global"
    else
      permission_option = "set_up_emails"
    end
    permission_to_show, permission_to_active, permission_message = check_user_permission(permission_option)
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    email_templates = EmailTemplate.where(:procedure_id => params[:current_process_id], :email_type => params[:email_type])
    email_templates.each do |email_template| # Select a template to use by email template id
      email_template.update_attributes(:is_active => email_template.id == params[:email_template_id].to_i)
    end

    email_template = EmailTemplate.find_by_id(params[:email_template_id]) # Get the selected template
    template_id_list = EmailTemplate.where(
      :procedure_id => params[:current_process_id],
      :email_type => params[:email_type]
    ).select(:id, :title, :is_active).order(:created_at => :asc) # Get new template list

    render :json => {:success => true, :email_template => email_template, :template_id_list => template_id_list}
  end

  private
    def email_template_params
      params.require(:email_template).permit(:id, :title, :content)
    end
end
