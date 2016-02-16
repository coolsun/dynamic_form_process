class Application < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :position;

  def ranked_mgr
    return User.find_by_id(self.mgr_ranked_user_id)
  end

  def position_name
    return self.position.name
  end

  def offer_msg(sub_step)
    if (sub_step == 'offer' && self.offered == "offered") || (sub_step != 'offer' && self.offered == "post_offered")
      if self.offer_accept == "accepted"
        return "Congratulations!  You have got the offer!!"
      elsif self.offer_accept == "rejected"
        return "Regret.  You have reject the offer."
      else
        return "Congratulations! You have been matched!! Please confirm your acceptance."
      end
    else
      return "Please wait for the match."
    end
  end

  def name
    return self.user.name
  end

  def self.get_mgr_rank_list(procedure_id, location_id)
    mgr_rank_list = {
      :rank_applications => [],
      :disable_rank_applications => [],
      :location_id => location_id
    }
    position_ids = Position.where(:location_id => location_id).pluck(:id)
    Application.includes(:user => :applicants, :position => [:location, :role]).references(:user).where(:offered => "wait", :position_id => position_ids, :disable_mgr_rank => nil).order("applications.mgr_rank asc").order("users.first_name asc").each do |application|
      mgr_rank_list[:rank_applications] << {
        :id => application.id,
        :suid => application.user.suid,
        :name => application.user.name,
        :rank => application.mgr_rank,
        :position_name => application.position.name
      } if application.user.applicants.detect{|obj| obj.procedure_id == procedure_id.to_i}.submit_and_not_disqualify
    end
    Application.includes(:user => :applicants, :position => [:location, :role]).references(:user).where(:offered => "wait", :position_id => position_ids, :disable_mgr_rank => true).order("users.first_name asc").each do |application|
      mgr_rank_list[:disable_rank_applications] << {
        :id => application.id,
        :suid => application.user.suid,
        :name => application.user.name,
        :rank => application.mgr_rank,
        :position_name => application.position.name
      } if application.user.applicants.detect{|obj| obj.procedure_id == procedure_id.to_i}.submit_and_not_disqualify
    end
    return mgr_rank_list
  end

  def self.get_user_rank_list(procedure_id, user_id)
   user_rank_list = {
      :rank_applications => [],
      :disable_rank_applications => []
    }

    Application.includes(:position => [:location, :role]).where(:positions => {:procedure_id => procedure_id}, :user_id => user_id, :offered => "wait", :disable_user_rank => nil).order("applications.user_rank asc").each do |application|
      user_rank_list[:rank_applications] << {
        :id => application.id,
        :rank => application.user_rank,
        :position_name => application.position.name
      }
    end

    Application.includes(:position => [:location, :role]).where(:positions => {:procedure_id => procedure_id}, :user_id => user_id, :offered => "wait", :disable_user_rank => true).order("locations.name asc").each do |application|
      user_rank_list[:disable_rank_applications] << {
        :id => application.id,
        :rank => application.user_rank,
        :position_name => application.position.name
      }
    end

    return user_rank_list
  end


  def self.update_positions_select(user_id, process_id, add_ids, delete_ids)
    db_position_ids = []
    self.joins(:position).where(:user_id => user_id, :positions => {:procedure_id => process_id}).each do |applicant|
      db_position_ids << applicant.position_id
    end
    totol_selected_position_ids = (add_ids | db_position_ids) - delete_ids
    logger.info "==totol_selected_position_ids = #{totol_selected_position_ids}=="
    select_position_limit = Procedure.find_by_id(process_id).select_position_limit
    new_create_position_ids = []
    if select_position_limit >= totol_selected_position_ids.length || select_position_limit == 0
      add_ids.each do |position_id|
        if !db_position_ids.include?(position_id.to_i)
          Application.create(:position_id => position_id, :user_id => user_id, :offered => "wait")
          new_create_position_ids << position_id
        end
      end
      if delete_ids.present?
        Application.where(:position_id => delete_ids, :user_id => user_id).destroy_all
      end
      return true, "You have selected the position(s) successfully.", new_create_position_ids
    else
      return false, "Maximum number of positions that can be selected per applicant: #{select_position_limit}", new_create_position_ids
    end
  end

  def self.pre_offer_fail_list(user_ids, position_id, procedure_id, sub_step)
    pre_offer_fail_list = []
    other_positions = Procedure.find_by_id(procedure_id).positions.pluck(:id) - [position_id]
    application_ids = []
    user_ids.each do |user_id|
      user = User.find_by_id(user_id)
      next unless user
      applications = self.where(:user_id => user_id, :position_id => other_positions, :offered => (sub_step == "offer" ? ["offered", "pre_offered"] : ["post_offered", "post_pre_offered"]))
      if applications.present?
        pre_offer_fail_list << {
          "applicant_name" => user.name,
          "position_name" => Position.find_by_id(applications.first.position_id).name
        }
      else
        application_ids << user_id
      end
    end
    logger.info "== pre_offer_fail_list #{pre_offer_fail_list.as_json} #{user_ids} =="
    return pre_offer_fail_list, application_ids
  end

  def self.get_offered_response_applicants(position_id)
    applicants = []

    Application.where(:position_id => position_id, :offered => "offered").each do |application|
      applicants << {
        :application_id => application.id,
        :applicant_name => application.user.name,
        :offer_accept => application.offer_accept.present? ? application.offer_accept : "not_select"
      }
    end

    return applicants
  end

end













