class User < ActiveRecord::Base
  has_paper_trail

  belongs_to :year
  has_one :peoplesoft_detail, :dependent => :destroy;
  has_many :recommendation_records, :dependent => :destroy;
  has_many :recommendation_forms, :primary_key => "sunet_id", :foreign_key => "recommender_sunet_id" # Don't add dependent.
  has_many :applications, :dependent => :destroy;
  has_many :interviewers, :dependent => :destroy;
  has_many :interviews, :through => :interviewers;
  has_many :time_slot_interviewers, :through => :interviewers;
  has_many :interviewees, :dependent => :destroy;
  has_many :time_slots, :through => :interviewees;
  has_many :procedure_mgrs, :dependent => :destroy;
  has_many :rd_mgrs, :dependent => :destroy;
  has_many :rd_records, :dependent => :destroy;
  has_many :procedures, :through => :procedure_mgrs;
  has_many :role_mgrs, :dependent => :destroy;
  has_many :roles, :through => :role_mgrs;
  has_many :location_mgrs, :dependent => :destroy;
  has_many :locations, :through => :location_mgrs;
  has_many :applicants, :dependent => :destroy;
  #has_many :invites;
  #has_many :interviews, :through => :invites;
  has_many :invitees, class_name: "Invite", :foreign_key => "invitee_user_id", :dependent => :destroy;
  has_many :inviters, class_name: "Invite", :foreign_key => "inviter_user_id", :dependent => :destroy;
  has_many :interviews, :through => :invitees;
  has_many :interviews, :through => :inviters;
  has_many :user_forms, :dependent => :destroy;
  has_many :reviewers, class_name: "InterviewEvaluate", :foreign_key => "judge_interviewer_user_id", :dependent => :destroy;
  has_many :user_procedures, :dependent => :destroy;
  has_many :transcripts, :dependent => :destroy;
  has_many :apply_white_lists, :dependent => :destroy


  validates_uniqueness_of :year_id, :scope => :sunet_id, :message => "This SUNet ID already exists."

  include RsasTools

  def self.default_scope
    # Should return a scope, you can call 'super' here etc.
  end

  def self.get_hiring_mgr_list(i_procedure_id)
    return (User.joins(:procedure_mgrs).where(:procedure_mgrs => {:procedure_id => i_procedure_id}));
  end

  def self.get_all_users_order_by_first_name
    return (User.all.order(:first_name));
  end

  def self.get_users_inner_interviewer_by_interview_id(i_interview_id)
    return (User.joins(:interviewers).where(:interviewers => {:interview_id => i_interview_id}));
  end

  def self.get_user_list(table_params)
    order_by_hash = {'Name' => 'lower(users.first_name)', 'SUNet ID' => 'users.sunet_id', 'Status' => 'users.status', 'Admin' => 'users.is_admin'}
    search_fields = ['users.first_name', 'users.sunet_id', 'users.middle_name', 'users.last_name', 'users.status']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "users.first_name asc"
    include_condition = [:procedures, :roles, :locations, :interviewers, :user_procedures]
    users = User.includes(include_condition)
                .references(include_condition)
                .where("user_procedures.procedure_id = ? or users.is_admin = 1", table_params.current_process_id)
                .where(:year_id => table_params.current_year_id)
                .where(search_condition)
                .order(order_condition)
                .page(table_params.i_page)
                .per(table_params.i_page_count)

    user_list = users.as_json(:include => [:procedures, {:roles => {:methods => :procedure_name}}, {:locations => {:methods => :procedure_name}}], :methods => [:name, :is_interviewer])

    return user_list, users.total_count
  end

  def get_mgr_procedure_ids
    procedure_ids = []
    all_procedure_ids = Procedure.pluck(:id)

    if self.is_admin
      procedure_ids = all_procedure_ids
    else
      procedure_ids = procedure_ids | self.procedure_mgrs.pluck(:procedure_id)
      procedure_ids = procedure_ids | self.rd_mgrs.pluck(:procedure_id)
      procedure_ids = procedure_ids | self.locations.pluck(:procedure_id)
      procedure_ids = procedure_ids | self.roles.pluck(:procedure_id)
      procedure_ids = procedure_ids | Round.joins(:interviews => :interviewers).where(:interviewers => {:user_id => self.id}).pluck(:procedure_id)
    end

    return procedure_ids
  end

  def name
    return [self.first_name, self.middle_name, self.last_name].join(" ").gsub("  "," ").strip
  end

  def self.get_preferred_name(user_id)
    user = User.find_by_id(user_id)
    if user
      return  user.preferred_name.present? ? user.preferred_name : user.first_name
    end
    return ""
  end

  def is_interviewer
    return self.interviewers.present?
  end

  def address
    if self.peoplesoft_detail && self.peoplesoft_detail.addresses && self.peoplesoft_detail.addresses.downcase != "null"
      address_json = JSON.parse(self.peoplesoft_detail.addresses)
      if address_json.present?
        address_obj = address_json.select{|address| address["type"] == "HOME"}
        if address_obj.present?
          return address_obj.first["address"]
        else
          return address_json.first["address"]
        end
      end
    end

    return ""
  end

  def phone
    if self.peoplesoft_detail && self.peoplesoft_detail.phones && self.peoplesoft_detail.phones.downcase != "null"
      phone_json = JSON.parse(self.peoplesoft_detail.phones)
      if phone_json.present?
        phone_obj = phone_json.select{|phone| phone["type"] == "CELL"}
        if phone_obj.present?
          return phone_obj.first["phoneNumber"]
        else
          return phone_json.first["phoneNumber"]
        end
      end
    end

    return ""
  end

  def academic_records
    begin
      return JSON.parse(self.peoplesoft_detail.academic_standings)
    rescue Exception => e
      logger.error "==user academic_record error: user.id = #{self.id}. Error:#{e.message}=="
      return nil
    end
  end

  def academic_standing(look_man_id)
    look_man = User.find_by_id(look_man_id)
    if (look_man.is_admin || look_man.status == "Staff" || look_man_id == self.id) && self.peoplesoft_detail && self.peoplesoft_detail.academic_standings && self.peoplesoft_detail.academic_standings.downcase != "null"
      academic_standing_json = self.academic_records
      if academic_standing_json.present?
        str = ""
        academic_standing_json.each do |academic_standing|
          str = str + "Quarter: " + academic_standing["quarter"] + ", "
          str = str + "Standing: " + academic_standing["standing"] + ", "
          str = str + "EffectDate: " + academic_standing["effectDate"] + "<br>"
        end
        return str
      end
    end

    return ""
  end

  def academics_gpa(look_man_id)
    look_man = User.find_by_id(look_man_id)
    if (look_man.is_admin || look_man.status == "Staff" || look_man_id == self.id) && self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("cumGPA") ? academics["cumGPA"] : " "}.join(", ")
      end
    end
    return ""
  end

  def academics_status
    if self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("status") ? academics["status"] : " "}.join(", ")
      end
    end
    return ""
  end

  def academics_type
    if self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("academicPlanType") ? academics["academicPlanType"] : " "}.join(", ")
      end
    end
    return ""
  end

  def academics_plan
    if self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("academicPlan") ? academics["academicPlan"] : " "}.join(", ")
      end
    end
    return ""
  end

  def academics_career
    if self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("academicCareer") ? academics["academicCareer"] : " "}.join(", ")
      end
    end
    return ""
  end

  def academics_term
    if self.peoplesoft_detail && self.peoplesoft_detail.academics && self.peoplesoft_detail.academics.downcase != "null"
      academics_json = JSON.parse(self.peoplesoft_detail.academics)
      if academics_json.present?
        return academics_json.collect{|academics| academics.has_key?("admitTerm") ? academics["admitTerm"] : " "}.join(", ")
      end
    end
    return ""
  end

  def get_user_all_position_names(procedure_id)
    position_ids = Application.where(:user_id => self.id).pluck(:position_id)
    return Position.includes(:location, :role).where(:id => position_ids, :procedure_id => procedure_id).collect{|position| position.name}.join(", ")
  end

  def get_user_all_role_names(procedure_id)
    position_ids = Application.where(:user_id => self.id).pluck(:position_id)
    return Position.includes(:location, :role).where(:id => position_ids, :procedure_id => procedure_id).collect{|position| position.role.name}.uniq.join(", ")
  end

  def self.get_or_create_other_year_user(source_user_id, target_year_id)
    source_user = User.find_by_id(source_user_id)
    return nil unless source_user
    return nil if source_user.sunet_id.blank?
    target_user = User.where(:year_id => target_year_id, :sunet_id => source_user.sunet_id).first
    if !target_user
      source_user_params = source_user.as_json(:only => [:first_name, :middle_name, :last_name, :status, :is_admin, :sunet_id])
      source_user_params[:year_id] = target_year_id
      target_user = User.create!(source_user_params)
    end

    return target_user
  end

  def self.check_user_or_create(s_sunet_id, i_year_id, s_status, s_email, s_first_name, s_middle_name = nil, s_last_name = nil)
    user = User.where(:sunet_id => s_sunet_id)
               .where(:year_id => i_year_id).first;

    if (user.blank?)
      user = User.create(
        :first_name => s_first_name,
        :middle_name => s_middle_name,
        :last_name => s_last_name,
        :email => s_email,
        :sunet_id => s_sunet_id,
        :year_id => i_year_id,
        :status => s_status
      );
    else
      user.status = s_status;
      user.email = s_email;
      user.first_name = s_first_name;
      user.middle_name = (s_middle_name.present?)? s_middle_name : user.middle_name;
      user.last_name = (s_last_name.present?)? s_middle_name : user.last_name;
      user.save();
    end

    return user;
  end

  def self.get_and_check_user_authority(session_user_id, params_user_id, request_headers_remote_user, is_admin)
    user = nil;
    if is_admin && params_user_id #admin change user
      user = User.find_by_id(params_user_id)
    elsif session_user_id #not login page
      user_id = session_user_id.to_i;
      user = User.find_by_id(user_id)
    elsif !STANFORD68 and Rails.env == 'development' #sca auto login
      user = User.find_by_id(1)
    #elsif cookies['REMOTE_USER'].present? #stanford user
    #  user = User.joins(:year).where(:sunet_id => cookies['REMOTE_USER'], :years => {:is_current_year => true}).first
    #end
    elsif request_headers_remote_user.present? #stanford user
      logger.info "====UsersController==get_user_authority=================request_headers_remote_user = #{request_headers_remote_user}=================================="
      user = User.joins(:year).where(:sunet_id => request_headers_remote_user, :years => {:is_current_year => true}).first
      if !user
        user = User.create_by_remote_user(request_headers_remote_user)
      end
    end

    return user;
  end

  def self.create_by_remote_user(sunet_id)
    year = Year.where(:is_current_year => true).first
    return nil if year.blank?
    user = User.create(
      :first_name => sunet_id,
      :year_id => year.id,
      :email => "#{sunet_id}@stanford.edu",
      :sunet_id => sunet_id
    )
  end

  def is_staff
    return (self.status == "Staff" || self.is_admin) ? true : false
  end

  def self.check_scheduling_conflict(t_start, t_end, i_user_id)
    b_is_busy = false;

    # interviewee schedule
    if (!b_is_busy)
      time_slots = TimeSlot.joins(:interviewees)
                           .where(:interviewees => {:user_id => i_user_id})
                           .where("(t_start < ? AND t_end > ?) OR (t_start < ? AND t_end > ?) OR (t_start = ? AND t_end = ?)", t_start, t_start, t_end, t_end, t_start, t_end);

      if (time_slots.present?)
        b_is_busy = true;
      end
    end

    # interviewer schedule
    if (!b_is_busy)
      time_slots = TimeSlot.joins(:time_slot_interviewers => [:interviewer])
                           .where(:interviewers => {:user_id => i_user_id})
                           .where("(t_start < ? AND t_end > ?) OR (t_start < ? AND t_end > ?) OR (t_start = ? AND t_end = ?)", t_start, t_start, t_end, t_end, t_start, t_end);

      if (time_slots.present?)
        b_is_busy = true;
      end
    end

    return (b_is_busy);
  end


  def self.check_is_manager(positions, i_user_id, i_procedure_id = nil)
    # this method is 'OR' logic.
    # positioins : ['admin', 'hm', 'rm', 'lm', 'rd'];
    b_is_manager = false;

    if ('admin'.in?(positions))
      admin = User.where(:id => i_user_id)
                  .where(:is_admin => true);

      logger.info("admin : #{admin.to_json}");

      if (admin.present?)
        b_is_manager = true;
      end
    end

    if ('hm'.in?(positions) && !b_is_manager)
      hm = nil;
      if (i_procedure_id.present?)
        hm = ProcedureMgr.where(:user_id => i_user_id)
                         .where(:procedure_id => i_procedure_id);
      else
        hm = ProcedureMgr.where(:user_id => i_user_id);
      end

      logger.info("hm : #{hm.to_json}");

      if (hm.present?)
        b_is_manager = true;
      end
    end

    if ('rm'.in?(positions) && !b_is_manager)
      rm = nil;
      if (i_procedure_id.present?)
        rm = RoleMgr.joins(:role)
                    .where(:user_id => i_user_id)
                    .where(:roles => {:procedure_id => i_procedure_id});
      else
        rm = RoleMgr.where(:user_id => i_user_id);
      end

      logger.info("rm : #{rm.to_json}");

      if (rm.present?)
        b_is_manager = true;
      end
    end


    if ('lm'.in?(positions) && !b_is_manager)
      lm = nil;
      if (i_procedure_id.present?)
        lm = LocationMgr.joins(:location)
                        .where(:user_id => i_user_id)
                        .where(:locations => {:procedure_id => i_procedure_id});
      else
        lm = LocationMgr.where(:user_id => i_user_id);
      end

      logger.info("lm : #{lm.to_json}");

      if (lm.present?)
        b_is_manager = true;
      end
    end


    if ('rd'.in?(positions) && !b_is_manager)
      rd = nil;
      if (i_procedure_id.present?)
        rd = RdMgr.where(:user_id => i_user_id)
                  .where(:procedure_id => i_procedure_id);
      else
        rd = RdMgr.where(:user_id => i_user_id);
      end

      logger.info("rd : #{rd.to_json}");

      if (rd.present?)
        b_is_manager = true;
      end
    end


    return (b_is_manager);
  end

  def applicant_tags(procedure_id)
    applicant_tags = []
    applicant = Applicant.where(:procedure_id => procedure_id, :user_id => self.id).first
    applicant_tags = applicant.applicant_tags.pluck(:name) if applicant

    return applicant_tags
  end

  def self.parse_peoplesoft(peoplesoft_message)
    return (OpenStruct.new({
      first_name: peoplesoft_message["firstName"],
      middle_name: peoplesoft_message["middleName"],
      last_name: peoplesoft_message["lastName"],
      suid: peoplesoft_message["suid"],
      email: peoplesoft_message["email"],
      sunet_id: peoplesoft_message["sunetId"],
      gender: peoplesoft_message["gender"],
      housingRemainYears: peoplesoft_message["housingRemainYears"],
      academics: peoplesoft_message["academics"].to_json,
      addresses: peoplesoft_message["addresses"].to_json,
      academicStandings: peoplesoft_message["academicStandings"].to_json,
      phones: peoplesoft_message["phones"].to_json
    }));

  end


####################################################################################################
  def self.get_position_applicants(i_procedure_id, position_ids)
    return (
      User.joins(:applicants, :applications)
          .where(:applicants => {:procedure_id => i_procedure_id, :disqualify => false})
          .where("applicants.application_submit_at IS NOT NULL")
          .where(:applications => {:position_id => position_ids})
    );

  end

####################################################################################################
  def self.get_under_manage_applicants(i_procedure_id, position_ids, b_senior_manager)
    if (b_senior_manager)
      return (
        User.joins(:applicants)
            .where(:applicants => {:procedure_id => i_procedure_id, :disqualify => false})
            .where("applicants.application_submit_at IS NOT NULL")
      );

    else
      return (
        User.joins(:applicants, :applications)
            .where(:applicants => {:procedure_id => i_procedure_id, :disqualify => false})
            .where("applicants.application_submit_at IS NOT NULL")
            .where(:applications => {:position_id => position_ids})
      );
    end

    return nil;
  end

  def self.interviewer(i_interview_id)
    return(
      User.joins(:interviewers)
          .where(:interviewers => {:interview_id => i_interview_id})
    );
  end




end
