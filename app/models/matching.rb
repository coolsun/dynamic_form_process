class Matching < ActiveRecord::Base
  def self.data(procedure_id)
    match_data = {}
    match_data[:positions] = []
    not_match_user_ids = []
    match_user_ids = []
    include_condition = [{:applications => :user}]
    Position.includes(include_condition).references(include_condition).where(:procedure_id => procedure_id, :auto_matching => true).order("lower(positions.name) asc").each do |position|
      users = []
      position.applications.each do |applicant|
        if applicant.auto_match
          users << applicant.user.as_json(:methods => :name)
          match_user_ids << applicant.user_id
        else
          not_match_user_ids << applicant.user_id
        end
      end
      match_data[:positions] << {
        :id => position.id,
        :name => position.name,
        :vacancy => position.vacancy,
        :users => users
      }
    end
    match_data[:not_match_users] = User.where(:id => (not_match_user_ids.uniq - match_user_ids.uniq)).as_json(:methods => :name)
    return match_data
  end

  def self.run_match(procedure_id, conditions)
    selection_ranks = OptimizedGs.match(Matching.position_ranks(procedure_id), Matching.applicant_ranks(procedure_id), Matching.constraints(conditions))
    return false if !selection_ranks

    return Matching.save_match(procedure_id, selection_ranks)
  end

  def self.position_ranks(procedure_id)
    ranks = {}
    Location.includes(:positions => :applications).where(:procedure_id => procedure_id).each do |location|
      location_positions = {"positions" => [], "ranks_by_location" => {}}
      Application.joins(:position => [:location]).where(:locations => {:id => location.id}, :disable_mgr_rank => nil, :offered => "wait").each do |application|
        location_positions["ranks_by_location"][[application.user_id, application.position.name]] = application.mgr_rank
      end

      location.positions.each do |position|
        if position.auto_matching
          location_positions["positions"] << {
            "position" => position.name,
            "vacancy" => position.vacancy,
            "ranks" => position.ranking_user_ids
          }
        end
      end

      if location_positions["positions"].present? || location_positions["ranks_by_location"].present?
        ranks[location.name] = location_positions
      end
    end

    return ranks
  end

  def self.applicant_ranks(procedure_id)
    ranks = {}
    user_ids = Application.joins(:position).where(:positions => {:procedure_id => procedure_id, :auto_matching => true}).pluck(:user_id).uniq

    user_id_conditions = user_ids.each_slice(1000).to_a.map{|o| "user_id in ('#{o.join("','")}')"}.join(' or ')

    Applicant.includes(:applicant_tags).where("procedure_id = ? and (#{user_id_conditions})", procedure_id).each do |applicant|

      ranks[applicant.user_id] = {
        "tags" => applicant.applicant_tags.collect{|o| {o.name => o.name}},
        "ranks" => applicant.ranking_position_names
      }
    end

    return ranks
  end

  def self.constraints(conditions)
    constraints = {}
    return constraints if conditions.blank?

    conditions.each do |condition|
      constraints[condition[:location][:name]] = {
        "total_score" => 0,
        "tag_score" => 0,
        "selection_score" => 0,
        #"tag_value" => {},
        "tag" => {}
      } if !constraints[condition[:location][:name]]

      constraints[condition[:location][:name]]["tag"][condition[:tag]] = [condition[:symbol], condition[:value]]
    end

    return constraints
  end

  def self.save_match(procedure_id, selection_ranks)
    is_success = false
    begin
      Application.joins(:position).where(:auto_match => true,:positions => {:procedure_id => procedure_id}).update_all(:auto_match => false)

      selection_ranks.each do |location_id, location_data|
        location_data["positions"].each do |position|
          position_id = position["position"]
          user_ids = position["ranks"]
          Application.where(:position_id => position_id, :user_id => user_ids).update_all(:auto_match => true)
        end
      end
      is_success = true
    rescue Exception => e
      Application.joins(:position).where(:auto_match => true,:positions => {:procedure_id => procedure_id}).update_all(:auto_match => false)
      flash[:notice]="Failed:#{e.message}"
      logger.error "#{e.message} : #{e.backtrace}"
    end

    return is_success
  end
end
