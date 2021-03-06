class RankingController < ApplicationController

  def get_user_rank_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Ranking")
    procedure_id = params[:current_process_id]
    user_id = current_user.id

    user_rank_list = Application.get_user_rank_list(procedure_id, user_id)

    rank_position_applicant_view = SystemMessage.where(:procedure_id => procedure_id, :identify_name => "rank_position_applicant_view").first.message

    render :json => {:user_rank_list => user_rank_list, :permission_to_active => permission_to_active, :rank_position_applicant_view => rank_position_applicant_view}
  end

  def update_user_rank
    permission_to_show, permission_to_active, permission_message = check_user_permission("Applicant Ranking")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id]
    rank_applications = params[:user_rank_list][:rank_applications]
    disable_rank_applications = params[:user_rank_list][:disable_rank_applications]
    user_id = current_user.id

    rank_applications.each_with_index do |application, index|
      Application.update(application[:id], {:user_rank => index + 1, :disable_user_rank => nil})
    end if rank_applications.present?

    disable_rank_applications.each_with_index do |application, index|
      Application.update(application[:id], {:user_rank => 999999, :disable_user_rank => true})
    end if disable_rank_applications.present?

    applicant = Applicant.where(:user_id => user_id, :procedure_id => procedure_id).first
    applicant.ranked_at = Time.now
    applicant.save

    user_rank_list = Application.get_user_rank_list(procedure_id, user_id)

    #Send notifi email after applicant update rank position
    send_success, msg, data = Application.send_email(current_user, procedure_id, "applicants_submit_ranked_list", user_rank_list: user_rank_list)
    render :json => {:success => send_success, :msg => msg , :user_rank_list => data}
  end

  def get_mgr_rank_list
    permission_to_show, permission_to_active, permission_message = check_user_permission("ranking")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    location_list = []
    location_ids = []
    position_list = []

    procedure_id = params[:current_process_id]
    if is_admin || is_hiring_mgr(procedure_id)
      location_list = Location.select(:id, :name).where(:procedure_id => procedure_id).order("name asc").as_json
    else
      location_list = Location.select(:id, :name).where(:procedure_id => procedure_id, :id => current_user_location_mgr_location_ids).order("name asc").as_json
    end

    location_ids = location_list.collect{|obj| obj["id"]}

    selected_location_id = params[:selected_location_id] if location_ids.include?(params[:selected_location_id].to_i)


    match_conditions = []
    mgr_rank_list = []
    selected_location = selected_location_id ? Location.find_by_id(selected_location_id) : nil

    if selected_location
      position_list = Position.select(:id, :name).where(:location_id => selected_location.id).as_json

      positions = Position.select(:id, :match_conditions).where(:location_id => selected_location.id).where('match_conditions is not null');

      positions.each do |position|
        position.match_conditions.each do |condition|
          match_conditions << {
            :position => position.id,
            :sex => condition["sex"],
            :symbol => condition["symbol"],
            :value => condition["value"]
          };
        end
      end

      mgr_rank_list = Application.get_mgr_rank_list(procedure_id, selected_location_id, current_user)
    end

    rank_position_manager_view = SystemMessage.where(:procedure_id => procedure_id, :identify_name => "rank_position_manager_view").first.message

    render :json => {
      :success => true,
      :mgr_rank_list => mgr_rank_list,
      :permission_to_active => permission_to_active,
      :location_list => location_list,
      :rank_position_manager_view => rank_position_manager_view,
      :match_conditions => match_conditions,
      :position_list => position_list
    }
  end

  def update_mgr_rank
    permission_to_show, permission_to_active, permission_message = check_user_permission("ranking")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_active

    procedure_id = params[:current_process_id]

    current_user_id = current_user.id
    current_user_name = User.find_by_id(current_user_id).first_name

    rank_applications = params[:mgr_rank_list][:rank_applications]
    disable_rank_applications = params[:mgr_rank_list][:disable_rank_applications]
    selected_location_id = params[:mgr_rank_list][:location_id]
    match_conditions = params[:match_conditions] || []

    rank_applications.each_with_index do |application, index|
      Application.update(application[:id], {:mgr_rank => index + 1, :disable_mgr_rank => nil, :mgr_ranked_at => Time.now, :mgr_ranked_user_id => current_user.id})
    end if rank_applications.present?

    disable_rank_applications.each_with_index do |application, index|
      Application.update(application[:id], {:mgr_rank => 999999, :disable_mgr_rank => true, :mgr_ranked_at => Time.now, :mgr_ranked_user_id => current_user.id})
    end if disable_rank_applications.present?

    selected_location = selected_location_id ? Location.find_by_id(selected_location_id) : nil

    mgr_rank_list = []
    return_match_conditions = []
    if selected_location
      logger.info "match_conditions = #{match_conditions.as_json}"

      positions = Position.where(:location_id => selected_location.id);
      Position.deal_match_conditions(positions, match_conditions);

      positions = Position.select(:id, :match_conditions).where(:location_id => selected_location.id).where('match_conditions is not null');
      positions.each do |position|
        position.match_conditions.each do |condition|
          return_match_conditions << {
            :position => position.id,
            :sex => condition["sex"],
            :symbol => condition["symbol"],
            :value => condition["value"]
          };
        end
      end


      mgr_rank_list = Application.get_mgr_rank_list(procedure_id, selected_location_id, current_user)
    end

    # Send notifi email after manager update rank position
    location_mgrs = LocationMgr.where(:location_id => selected_location_id, :user_id => current_user.id)
    if location_mgrs.present?
      all_location_mgrs = LocationMgr.joins(:user).where(location_id: selected_location_id).pluck(:email)
      bcc = all_location_mgrs
      send_success, msg, data = Application.send_email(current_user, procedure_id, "location_managers_submit_ranked_list", add_bcc: bcc, mgr_rank_list: mgr_rank_list)
      render :json => {:success => send_success, :msg => msg , :mgr_rank_list => data, :match_conditions => match_conditions}
    else
      render :json => {:success => true, :msg => "The rank has been updated successfully.", :mgr_rank_list => mgr_rank_list, :match_conditions => return_match_conditions}
    end
  end

end
