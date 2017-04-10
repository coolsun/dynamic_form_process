class Matching < ActiveRecord::Base
  def self.data(procedure_id)
    match_data = {}
    match_data[:positions] = []
    match_data[:match_conditions] = [];
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

      if (position.auto_matching && position.match_conditions.present?)
        match_data[:match_conditions] += position.match_conditions;
      end
    end
    match_data[:not_match_users] = User.where(:id => (not_match_user_ids.uniq - match_user_ids.uniq)).as_json(:methods => :name)
    return match_data
  end

  def self.run_match(procedure_id, conditions)
    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    logger.info("@@@@@@@@@@@@@ run_match @@@@@@@@@@@@@@@@@@@@@");
    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    logger.info(conditions);

    include_condition = [{:applications => :user}, :location];
    positions = Position.includes(include_condition).references(include_condition).where(:procedure_id => procedure_id, :auto_matching => true);

    Position.deal_match_conditions(positions, conditions);


    location_ids = positions.map{|position| position.location_id}.uniq;
    locations = Location.where(id: location_ids).select("id, is_row_house");

    match_locations = [];
    locations.each do |location|
      match_locations << {:name=> location.id.to_s, :rowHouse => location.is_row_house}
    end

    match_positions = [];
    match_students = {};

    positions.each_with_index do |position, position_index|
      rules = [];
      if (conditions.present?)
        conditions.each do |condition|
          if (condition['position'] == position.id)
            case condition['sex']
            when 'Female'
              rule_sex = 'f';
            when 'Male'
              rule_sex = 'm';
            else
              rule_sex = 'o';
            end

            rules << rule_sex + condition['symbol'] + condition['value'].to_s;
          end
        end
      end

      tmp_position = {};
      tmp_position[:house] = position.location_id.to_s;
      tmp_position[:vacancies] = position.vacancy;
      tmp_position[:name] = position.id.to_s;
      tmp_position[:rule] = rules.join('&&');
      tmp_position[:size] = 0;

      i_count_applications = 0;
      ranking_applications = position.applications
                                      .where('disable_user_rank is null OR disable_user_rank = 0')
                                      .where('disable_mgr_rank is null OR disable_mgr_rank = 0')
                                      .where('user_rank != 999999')
                                      .order(:mgr_rank);

      ranking_applications.each_with_index do |application, appliction_index|
        applicant = Applicant.where(:user_id => application.user_id, :procedure_id => procedure_id).last;
        if (!applicant.disqualify)
          if(match_students[application.user_id.to_s].blank?)
            match_students[application.user_id.to_s] = {};
          end

          student = application.user;
          sex = 'UNKNOWN';
          case student.gender
          when 'M'
            sex = 'Male';
          when 'F'
            sex = 'Female';
          else
            sex = 'Other';
          end

          if (match_students[application.user_id.to_s][:sex].blank?)
            match_students[application.user_id.to_s][:sex] = sex;
          end

          match_students[application.user_id.to_s][application.position_id.to_s] = application.user_rank;
          tmp_position[appliction_index] =[student.id.to_s, sex];
          i_count_applications += 1;
        end
      end


      if (0 < i_count_applications)
        tmp_position[:size] = i_count_applications;
        match_positions << tmp_position;
      end
    end

    #selection_ranks = OptimizedGs.match(Matching.position_ranks(procedure_id), Matching.applicant_ranks(procedure_id), Matching.constraints(conditions))

    begin
      result = MatchGsPosNoGv.do_match(match_locations, match_positions, match_students);
      logger.info("@@ MatchGsPos.do_match result: #{result}");

      if (result[:done])
        is_success = Matching.save_match(procedure_id, result[:data])

        if (is_success)
          return {
            success: true,
            msg: 'The match is run successfully!'
          }
        else
          return {
            success: false,
            msg: 'Failed to match. save_match failed.'
          }
        end
      else
        if (!result[:b_ValidSelection])
          return {
            success: false,
            msg: 'Failed to match. Some positions have no ValidSelection.'
          }
        else
          return {
            success: false,
            msg: 'Failed to match. match_gs_pos.rb has unknown error.'
          }
        end
      end
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      return {
        success: false,
        msg: 'Failed to match. match_gs_pos.rb has unknown error.'
      }
    end

    #return Matching.save_match(procedure_id, selection_ranks)
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

      selection_ranks.each do |data|
        position_id = data["position_id"]
        user_ids = data["user_ids"]
        Application.where(:position_id => position_id, :user_id => user_ids).update_all(:auto_match => true)
      end
      is_success = true
    rescue Exception => e
      Application.joins(:position).where(:auto_match => true,:positions => {:procedure_id => procedure_id}).update_all(:auto_match => false)
      logger.error "#{e.message} : #{e.backtrace}"
    end

    return is_success
  end


private
  def show_matching_data_struct
    procedure_id = 10560;
    conditions = [{"position"=>15687, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15687, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15695, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15695, "sex"=>"Female", "symbol"=>">=", "value"=>3}, {"position"=>15698, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15698, "sex"=>"Female", "symbol"=>">=", "value"=>3}, {"position"=>15707, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15707, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15724, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15724, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15732, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15732, "sex"=>"Male", "symbol"=>"==", "value"=>1}, {"position"=>15744, "sex"=>"Male", "symbol"=>">=", "value"=>3}, {"position"=>15744, "sex"=>"Female", "symbol"=>">=", "value"=>4}, {"position"=>15459, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15459, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15497, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15497, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15500, "sex"=>"Male", "symbol"=>"==", "value"=>3}, {"position"=>15500, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15565, "sex"=>"Female", "symbol"=>">=", "value"=>3}, {"position"=>15661, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15661, "sex"=>"Female", "symbol"=>">=", "value"=>3}, {"position"=>15566, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15566, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15532, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15532, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15529, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15529, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15535, "sex"=>"Female", "symbol"=>"==", "value"=>1}, {"position"=>15533, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15533, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15534, "sex"=>"Male", "symbol"=>"==", "value"=>1}, {"position"=>15554, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15554, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15583, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15583, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15600, "sex"=>"Male", "symbol"=>">=", "value"=>1}, {"position"=>15600, "sex"=>"Female", "symbol"=>">=", "value"=>1}, {"position"=>15601, "sex"=>"Female", "symbol"=>"==", "value"=>1}, {"position"=>15608, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15608, "sex"=>"Male", "symbol"=>">=", "value"=>3}, {"position"=>15609, "sex"=>"Male", "symbol"=>"==", "value"=>1}, {"position"=>15609, "sex"=>"Female", "symbol"=>"==", "value"=>1}, {"position"=>15626, "sex"=>"Male", "symbol"=>">=", "value"=>2}, {"position"=>15626, "sex"=>"Female", "symbol"=>">=", "value"=>2}, {"position"=>15629, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15629, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15631, "sex"=>"Female", "symbol"=>"==", "value"=>3}, {"position"=>15631, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15634, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15634, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15638, "sex"=>"Male", "symbol"=>">=", "value"=>3}, {"position"=>15638, "sex"=>"Female", "symbol"=>">=", "value"=>4}, {"position"=>15568, "sex"=>"Male", "symbol"=>"==", "value"=>2}, {"position"=>15568, "sex"=>"Female", "symbol"=>"==", "value"=>2}, {"position"=>15569, "sex"=>"Male", "symbol"=>"==", "value"=>1}, {"position"=>15569, "sex"=>"Female", "symbol"=>"==", "value"=>1}]


    include_condition = [{:applications => :user}, :location];
    positions = Position.includes(include_condition).references(include_condition).where(:procedure_id => procedure_id, :auto_matching => true);

    Position.deal_match_conditions(positions, conditions);


    location_ids = positions.map{|position| position.location_id}.uniq;
    locations = Location.where(id: location_ids);

    match_locations = [];
    locations.each do |location|
      match_locations << {:name=> location.name, :rowHouse => location.is_row_house}
    end

    match_positions = [];
    match_students = {};

    positions.each_with_index do |position, position_index|
      rules = [];
      if (conditions.present?)
        conditions.each do |condition|
          if (condition['position'] == position.id)
            case condition['sex']
            when 'Female'
              rule_sex = 'f';
            when 'Male'
              rule_sex = 'm';
            else
              rule_sex = 'o';
            end

            rules << rule_sex + condition['symbol'] + condition['value'].to_s;
          end
        end
      end

      tmp_position = {};
      tmp_position[:house] = position.location.name;
      tmp_position[:vacancies] = position.vacancy;
      tmp_position[:name] = position.name;
      tmp_position[:rule] = rules.join('&&');
      tmp_position[:size] = 0;

      i_count_applications = 0;
      ranking_applications = position.applications
                                      .where('disable_user_rank is null OR disable_user_rank = 0')
                                      .where('disable_mgr_rank is null OR disable_mgr_rank = 0')
                                      .where('user_rank != 999999')
                                      .order(:mgr_rank);

      ranking_applications.each_with_index do |application, appliction_index|
        if(match_students[application.user.name].blank?)
          match_students[application.user.name.to_s] = {};
        end

        student = application.user;
        sex = 'UNKNOWN';
        case student.gender
        when 'M'
          sex = 'Male';
        when 'F'
          sex = 'Female';
        else
          sex = 'Other';
        end

        if (match_students[student.name][:sex].blank?)
          match_students[student.name][:sex] = sex;
        end

        match_students[student.name][application.position.name] = application.user_rank;
        tmp_position[appliction_index] =[student.name, sex];
        i_count_applications += 1;
      end


      if (0 < i_count_applications)
        tmp_position[:size] = i_count_applications;
        match_positions << tmp_position;
      end
    end

    match_locations_log = Logger.new("#{Rails.root}/public/match_locations.log");
    match_locations_log.info(match_locations);
    match_positions_log = Logger.new("#{Rails.root}/public/match_positions.log");
    match_positions_log.info(match_positions);
    match_students_log = Logger.new("#{Rails.root}/public/match_students.log");
    match_students_log.info(match_students);

  end


end
