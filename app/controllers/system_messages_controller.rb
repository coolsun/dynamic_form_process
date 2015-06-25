class SystemMessagesController < ApplicationController
  before_action :set_system_message, only: [:update]

  # GET /system_messages
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("system_message")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    system_messages = SystemMessage.where(:procedure_id => params[:current_process_id])

    render :json => {
      :success => true,
      :system_messages => system_messages,
      :permission_to_active => permission_to_active
    }
  end

  # PATCH/PUT /system_messages/1
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("system_message")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    if @system_message.update(system_message_params)
      system_messages = SystemMessage.where(:procedure_id => params[:current_process_id])
      render :json => {:success => true, :system_messages => system_messages, :msg => "The system message has been updated successfully."}
    else
      render :json => {:success => false, :msg => "There was a problem to update the system message."}
    end
  end

  private
    def set_system_message
      @system_message = SystemMessage.find_by_id(params[:id])
    end
    def system_message_params
      params.require(:system_message).permit(:procedure_id, :name, :message)
    end
end
