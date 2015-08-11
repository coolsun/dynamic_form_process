class ApplicationController < ActionController::Base
  #before_action :show_session
  #after_action :show_session

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token

  def show_sunet_id()
    logger.info "======== request.headers[\"REMOTE_USER\"] = #{request.headers["REMOTE_USER"]} ========";
  end

  def set_operator
    RecordWithOperator.operator = current_user
  end

  def test
    logger.info("@@@@@@@@@@@@@@ Appliction Test function start @@@@@@@@@@@@@@@@@");
=begin
    Procedure.all.each do |procedure|
      User.all.each do |user|
        session[:user_id] = user.id
        UserProcedure.create(:user_id => user.id, :procedure_id => procedure.id) if is_mgr_in_process(procedure.id)
      end
    end
=end

    logger.info("@@@@@@@@@@@@@@ Appliction Test function end @@@@@@@@@@@@@@@@@");
    render :json => {}
  end


  def show_session
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~#{session[:user_id]}~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~#{session[:return_url]}~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  def current_year
    return Year.find_by_is_current_year(true)
  end

  def current_user
    if session[:user_id].to_i != 0 && (!@current_user || @current_user.id != session[:user_id].to_i)
      @current_user = User.find_by_id(session[:user_id])
    elsif session[:user_id].to_i == 0
      @current_user = nil
    end
    return @current_user
  end

  def get_header_permission
    permissions = {}
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Clone")
    permissions[:show_menu_clone] = permission_to_show
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Global")
    permissions[:show_menu_global] = permission_to_show
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Process")
    permissions[:show_menu_process] = permission_to_show
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Report")
    permissions[:show_menu_report] = permission_to_show
    permission_to_show, permission_to_active, permission_message = check_user_permission("Menu Year")
    permissions[:show_menu_year] = permission_to_show
    permission_to_show, permission_to_active, permission_message = check_user_permission("import_mgrs_by_xlsx")
    permissions[:show_import_mgrs] = permission_to_show
    return permissions;
  end

  def is_admin
    return current_user ? current_user.is_admin : false
  end

  def is_mgr_in_process(procedure_id)
    return ((is_admin ||
             is_hiring_mgr(procedure_id) ||
             is_procedure_location_mgr(procedure_id) ||
             is_procedure_role_mgr(procedure_id))? true: false);
  end

  def is_hiring_mgr(procedure_id)
    return ProcedureMgr.where(:procedure_id => procedure_id, :user_id => current_user.id).first if current_user
  end

  def is_rd_mgr(procedure_id)
    return RdMgr.where(:procedure_id => procedure_id, :user_id => current_user.id).first if current_user
  end

  def is_procedure_location_mgr(procedure_id)
    return LocationMgr.joins(:location).where(:locations => {:procedure_id => procedure_id}, :user_id => current_user.id).first if current_user
  end

  def is_procedure_role_mgr(procedure_id)
    return RoleMgr.joins(:role).where(:roles => {:procedure_id => procedure_id}, :user_id => current_user.id).first if current_user
  end

  def is_procedure_interviewer(procedure_id)
    return Interviewer.joins(:interview => :round).where(:rounds => {:procedure_id => procedure_id}, :user_id => current_user.id).first if current_user
  end

  def is_location_mgr(location_id)
    return LocationMgr.where(:location_id => location_id, :user_id => current_user.id).first if current_user
  end

  def is_role_mgr(role_id)
    return RoleMgr.where(:role_id => role_id, :user_id => current_user.id).first if current_user
  end

  def current_user_location_mgr_location_ids
    ids = []
    current_user.location_mgrs.each do |location_mgr|
      ids << location_mgr.location_id
    end if current_user
    return ids
  end

  def current_user_role_mgr_role_ids
    ids = []
    current_user.role_mgrs.each do |role_mgr|
      ids << role_mgr.role_id
    end if current_user
    return ids
  end

  def current_user_location_mgr_location_ids_in_procedure(procedure_id)
    return Location.where(:procedure_id => procedure_id, :id => current_user_location_mgr_location_ids).pluck(:id)
  end

  def current_user_role_mgr_role_ids_in_procedure(procedure_id)
    return Role.where(:procedure_id => procedure_id, :id => current_user_role_mgr_role_ids).pluck(:id)
  end

  def current_user_manage_position_ids_in_procedure(procedure_id)
    under_manage_location_ids = current_user_location_mgr_location_ids_in_procedure(procedure_id);
    under_manage_role_ids = current_user_role_mgr_role_ids_in_procedure(procedure_id);

    under_manage_position_ids_by_location = Position.where(:location_id => under_manage_location_ids).pluck(:id);
    under_manage_position_ids_by_role = Position.where(:role_id => under_manage_role_ids).pluck(:id);

    position_ids = under_manage_position_ids_by_location | under_manage_position_ids_by_role;

    return (position_ids);
  end

  def get_error_messages(active_record)
    error_msgs = []
    active_record.errors.each do |attribute, message|
      error_msgs << message
    end
    return error_msgs.join(" ")
  end



  def rsas_table_params
    asc_or_desc = (0 == params[:ascOrDesc].to_i)? 'ASC' : 'DESC';
    page_count = params[:pageCount].to_i == 0 ? 2147483647 : params[:pageCount].to_i
    return (OpenStruct.new({
      :i_page_count => page_count,
      :i_page => params[:page].to_i,
      :s_asc_or_desc => (0 == params[:ascOrDesc].to_i)? 'ASC' : 'DESC',
      :us_search_text => params[:searchText],
      :us_order_by => params[:orderBy],
      :i_procedure_id => params[:procedureId].to_i,
      :current_process_id => params[:current_process_id],
      :current_year_id => params[:current_year_id]
    }));
  end

  def check_user_permissions(actions, all_options={})
    permissions = {}
    actions.each do |action|
      options = all_options[action] || {}
      permission_to_show, permission_to_active, permission_message  = check_user_permission(action, options)
      permissions[action] = {
        :show => permission_to_show,
        :active => permission_to_active,
        :message => permission_message
      }
    end

    return permissions.with_indifferent_access
  end

  def check_user_permission(action, options={})
    permission_to_show = false
    permission_to_active = false
    permission_message = ''
    visibility_group = []
    action_group = []
    case action
    #-------------------------------------------------------------------------------------menu-------------------------------------------------------------------------------------
    #group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'RD', 'Interviewer']
    when "Menu Clone"
      visibility_group = ['Admin']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups_but_not_by_procedure(visibility_group, action_group)

    when "Menu Global"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups_but_not_by_procedure(visibility_group, action_group)

    when "Menu Process"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'RD', 'Interviewer']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups_but_not_by_procedure(visibility_group, action_group)

    when "Menu Report"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups_but_not_by_procedure(visibility_group, action_group)

    when "Menu Year"
      visibility_group = ['Admin']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups_but_not_by_procedure(visibility_group, action_group)

    #-------------------------------------------------------------------------------------process-------------------------------------------------------------------------------------
    when "Process User"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Process RD"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Process Apply White List"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)


    #-------------------------------------------------------------------------------------process_step-----------------------------------------------------------------------------
    when "Process Step Sort And Display"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'RD', 'Interviewer']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Process"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'RD']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Application"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Interview"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Ranking"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Offer"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Post Match"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #-------------------------------------------------------------------------------------sub_step---------------------------------------------------------------------------------
    when "set_up_positions"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

      if permission_to_active && options[:position].present? && !is_admin && !is_hiring_mgr(params[:current_process_id])
        location_ids = current_user_location_mgr_location_ids
        role_ids = current_user_role_mgr_role_ids

        permission_to_active = options[:position].location_id.in?(location_ids) || options[:position].role_id.in?(role_ids)
      end

    when "set_up_rounds"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "rd_flag"
      visibility_group = ['Admin', 'HM', 'RD']
      action_group = ['Admin', 'HM', 'RD']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "roles_and_permissions"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "set_up_system_forms"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "set_up_recommendation_forms"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "set_up_interview_forms"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "set_up_attachable_forms"
      visibility_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      action_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "set_up_emails"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "system_message"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "applicants"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "manage_available_applicants"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "select_position"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "fill_in_form"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "recommendation"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "submit_application"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "interview"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "ranking"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'LM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'LM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "match"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "offer"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "post_offer_invitations"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "post_offer_fill_in_form"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "post_offer_recommendation"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)
=begin
    when "post_offer_interview"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)
=end
    when "post_offer_offer"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #-------------------------------------------------------------------------------------sub step actions-------------------------------------------------------------------------
    #set_up_positions
    when "Create role"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "Create Location"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "import_mgrs_by_xlsx"
      visibility_group = ['Admin']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #rd_flag
    when "rd_flag_button"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'RD']
      action_group = []
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #applicants
    when "lower_mgr_see_time"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'RD']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "time_to_see_applicant_forms"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']

      role_ids = current_user_role_mgr_role_ids_in_procedure(params[:current_process_id])
      role_limit_ids = LimitManager.where(:role_id => role_ids).pluck(:limit_period_id)
      role_limit_periods = LimitPeriod.where(:id => role_limit_ids).select(:id, :t_start, :t_end)
      role_limit_periods.each do |role_limit_period|
        if (role_limit_period.t_start && role_limit_period.t_start < Time.now) && (role_limit_period.t_end && role_limit_period.t_end > Time.now) then
          visibility_group.concat(['RM Staff', 'RM Student'])
          action_group.concat(['RM Staff', 'RM Student'])
          break
        end
      end
      location_ids = current_user_location_mgr_location_ids_in_procedure(params[:current_process_id])
      location_limit_ids = LimitManager.where(:location_id => location_ids).pluck(:limit_period_id)
      location_limit_periods = LimitPeriod.where(:id => location_limit_ids).select(:id, :t_start, :t_end)
      location_limit_periods.each do |location_limit_period|
        if (location_limit_period.t_start && location_limit_period.t_start < Time.now) && (location_limit_period.t_end && location_limit_period.t_end > Time.now) then
          visibility_group.concat(['LM Staff', 'LM Student'])
          action_group.concat(['LM Staff', 'LM Student'])
          break
        end
      end

      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "see_applicant_filled_forms"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "applicant_disqualify"
      visibility_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      action_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "help landing"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer', 'RD']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #interview
    when "interview_admin_page"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_create"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_setting"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_position"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_time_slot"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "select_interviewer"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "select_applicant"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "schedule_interviewer"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "schedule_applicant"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_delete"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "applicant_tags"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student', 'Interviewer'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "interview_review"
      same_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    #Manage Applicants
    when "Show Applicant All Form"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "force_submit"
      visibility_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      action_group = ['Admin', 'HM', 'RM Staff', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "manual_add_positions"
      visibility_group = ['Admin']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)


    #Offer Status
    when "import_pre_offered_applicants_by_xlsx"
      visibility_group = ['Admin']
      action_group = ['Admin']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "change_offered_response"
      visibility_group = ['Admin', 'HM']
      action_group = ['Admin', 'HM']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #-------------------------------------------------------------------------------------actions----------------------------------------------------------------------------------
    when "send_email_to_applicants"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "send_offered_email"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    when "send_invite_post_offer_email"
      visibility_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      action_group = ['Admin', 'HM', 'LM Staff', 'RM Staff', 'LM Student', 'RM Student']
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group)

    #-------------------------------------------------------------------------------------applicant--------------------------------------------------------------------------------
    when "Applicant Select Position"
      permission_to_show = true
      applicant_submit = Applicant.is_application_sumbit(session[:user_id], params[:current_process_id])
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "select_position", session[:user_id])
      permission_to_active = is_in_active_time & !applicant_submit
      permission_message = "You had missed the time." if !is_in_active_time
      permission_message = "You had submited." if applicant_submit

    when "Applicant Fill In Form"
      permission_to_show = true
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "fill_in_form", session[:user_id])
      permission_to_active = is_in_active_time
      permission_message = "You had missed the time." if !is_in_active_time

    when "Applicant Recommendation"
      permission_to_show = true
      permission_to_active = ProcedureSubStep.is_in_active_time(params[:current_process_id], "recommendation", session[:user_id])

    when "Applicant Submit Application"
      permission_to_show = true
      permission_to_active = ProcedureSubStep.is_in_active_time(params[:current_process_id], "submit_application", session[:user_id])

    when "Applicant System Form"
      permission_to_show = true
      permission_to_active = true

    when "Applicant Interview"
      permission_to_show = true
      permission_to_active = ProcedureSubStep.is_in_active_time(params[:current_process_id], "interview", session[:user_id])

    when "Applicant Ranking"
      permission_to_show = true
      permission_to_active = ProcedureSubStep.is_in_active_time(params[:current_process_id], "ranking", session[:user_id])

    when "Applicant Offer Status"
      permission_to_show = true
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "offer", session[:user_id])
      is_get_offered, is_accept_offered = Applicant.is_get_offered(session[:user_id], params[:current_process_id], false)
      permission_to_active = is_in_active_time & !is_accept_offered

    when "Applicant Post Match Select Position"
      permission_to_show = true
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "post_offer_invitations", session[:user_id])
      is_get_offered, is_accept_offered = Applicant.is_get_offered(session[:user_id], params[:current_process_id], true)
      permission_to_active = is_in_active_time & !is_get_offered

    when "Applicant Post Match Fill In Form"
      permission_to_show = true
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "post_offer_fill_in_form", session[:user_id])
      is_get_offered, is_accept_offered = Applicant.is_get_offered(session[:user_id], params[:current_process_id], true)
      permission_to_active = is_in_active_time & !is_get_offered

    when "Applicant Post Match Offer Status"
      permission_to_show = true
      is_in_active_time = ProcedureSubStep.is_in_active_time(params[:current_process_id], "post_offer_offer", session[:user_id])
      is_get_offered, is_accept_offered = Applicant.is_get_offered(session[:user_id], params[:current_process_id], true)
      permission_to_active = is_in_active_time & is_get_offered

    when "ApplicantUnderInterviewRound"
      round = options[:round];
      permission_to_show = true;
      permission_to_active = round.is_in_active_time(session[:user_id]);

    #########################################################################################################################
    # use in rails controller
    when "SeniorManager"
      same_group = ['Admin', 'HM'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    when "MiddleManager"
      same_group = ['LM Staff', 'RM Staff', 'LM Student', 'RM Student'];

      visibility_group = same_group;
      action_group = same_group;
      permission_to_show, permission_to_active = check_with_groups(action, options, visibility_group, action_group);

    #########################################################################################################################

    end

    if options[:return_permission]
      return {
        :visibility_group => visibility_group,
        :action_group => action_group
      }
    end


    permission_message = "Insufficient privileges" if ((permission_to_show.blank? || permission_to_active.blank?) && permission_message.blank?)

    logger.info "==check_user_permission==action = #{action} ==permission_to_show = #{permission_to_show} ==permission_to_active = #{permission_to_active} ==permission_message = #{permission_message}"
    return permission_to_show, permission_to_active, permission_message
  end

  def substep_check(visibility_group)

    return visibility_group
  end

  def check_with_groups(action, options, visibility_group, action_group)
    can_visibility = false
    can_action = false
    @permission ||= {}

    visibility_group, action_group = update_group_by_options(action, options, visibility_group, action_group)

    requirement_group = visibility_group | action_group
    user_group = []
    if current_user
      if 'Admin'.in?(requirement_group)
        if @permission['Admin'] || is_admin
          @permission['Admin'] = true;
          user_group << 'Admin';
        end
      end

      if 'HM'.in?(requirement_group)
        if @permission['HM'] || is_hiring_mgr(params[:current_process_id])
          @permission['HM'] = true;
          user_group << 'HM';
        end
      end

      if 'RD'.in?(requirement_group)
        if @permission['RD'] || is_rd_mgr(params[:current_process_id])
          @permission['RD'] = true;
          user_group << 'RD';
        end
      end

      if 'LM Staff'.in?(requirement_group)
        if @permission['LM Staff'] || (is_procedure_location_mgr(params[:current_process_id]) && current_user.status == 'Staff')
          @permission['LM Staff'] = true;
          user_group << 'LM Staff';
        end
      end

      if 'LM Student'.in?(requirement_group)
        if @permission['LM Student'] || (is_procedure_location_mgr(params[:current_process_id]) && current_user.status == 'Student')
          @permission['LM Student'] = true;
          user_group << 'LM Student';
        end
      end

      if 'RM Staff'.in?(requirement_group)
        if @permission['RM Staff'] || (is_procedure_role_mgr(params[:current_process_id]) && current_user.status == 'Staff')
          @permission['RM Staff'] = true;
          user_group << 'RM Staff';
        end
      end

      if 'RM Student'.in?(requirement_group)
        if @permission['RM Student'] || (is_procedure_role_mgr(params[:current_process_id]) && current_user.status == 'Student')
          @permission['RM Student'] = true;
          user_group << 'RM Student';
        end
      end

      if 'Interviewer'.in?(requirement_group)
        if @permission['Interviewer'] || is_procedure_interviewer(params[:current_process_id])
          @permission['Interviewer'] = true;
          user_group << 'Interviewer';
        end
      end
    end
    can_visibility = true if (user_group & visibility_group).present?
    can_action     = true if (user_group & action_group).present?
    return can_visibility, can_action
  end

  def check_with_groups_but_not_by_procedure(visibility_group, action_group)
    can_visibility = false
    can_action = false
    @permission ||= {}

    requirement_group = visibility_group | action_group
    user_group = []
    if current_user
      if 'Admin'.in?(requirement_group)
        if @permission['Admin'] || is_admin
          @permission['Admin'] = true;
          user_group << 'Admin';
        end
      end

      if 'HM'.in?(requirement_group)
        if @permission['HM'] || current_user.procedure_mgrs.present?
          @permission['HM'] = true;
          user_group << 'HM';
        end
      end

      if 'RD'.in?(requirement_group)
        if @permission['RD'] || current_user.rd_mgrs.present?
          @permission['RD'] = true;
          user_group << 'RD';
        end
      end

      if 'LM Staff'.in?(requirement_group)
        if @permission['LM Staff'] || (current_user.location_mgrs.present? && current_user.status == 'Staff')
          @permission['LM Staff'] = true;
          user_group << 'LM Staff';
        end
      end

      if 'LM Student'.in?(requirement_group)
        if @permission['LM Student'] || (current_user.location_mgrs.present? && current_user.status == 'Student')
          @permission['LM Student'] = true;
          user_group << 'LM Student';
        end
      end

      if 'RM Staff'.in?(requirement_group)
        if @permission['RM Staff'] || (current_user.role_mgrs.present? && current_user.status == 'Staff')
          @permission['RM Staff'] = true;
          user_group << 'RM Staff';
        end
      end

      if 'RM Student'.in?(requirement_group)
        if @permission['RM Student'] || (current_user.role_mgrs.present? && current_user.status == 'Student')
          @permission['RM Student'] = true;
          user_group << 'RM Student';
        end
      end

      if 'Interviewer'.in?(requirement_group)
        if @permission['Interviewer'] || current_user.interviewers.present?
          @permission['Interviewer'] = true;
          user_group << 'Interviewer';
        end
      end
    end
    can_visibility = true if (user_group & visibility_group).present?
    can_action     = true if (user_group & action_group).present?
    return can_visibility, can_action
  end

  def update_group_by_options(action, options, visibility_group, action_group)
    if options[:substep_check] && action != "applicants" && !ProcedureSubStep.find_by_id(options[:substep_check]).lm_see
      visibility_group -= ['LM Staff', 'LM Student']
    end
    return visibility_group, action_group
  end
end
