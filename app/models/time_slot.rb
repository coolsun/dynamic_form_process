class TimeSlot < ActiveRecord::Base
  has_paper_trail

  belongs_to :interview;
  has_many :interviewees;
  has_many :time_slot_interviewers;
  has_many :users, :through => :interviewees;
  has_many :interviewers, :through => :time_slot_interviewers;


  def self.new_time_slot(i_interview_id, s_place, t_start, t_end)
    time_slot = TimeSlot.create(:interview_id => i_interview_id, :place => s_place, :t_start => t_start, :t_end => t_end);
    return time_slot;
  end


  def self.admin_get_time_slots(table_params, i_interview_id)
    field_map={
      "Interview"=> "interviews.name",
      "Place"=> "time_slots.place",
      "Start"=> "time_slots.t_start",
      "End"=> "time_slots.t_end"
    };

    search_field = ['interviews.name', 'time_slots.place'];

    order_condition = table_params.us_order_by.blank? ? 'interviews.name ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    include_list = [:interview];
    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);
    time_slots = nil;

    time_slots = TimeSlot.includes(include_list)
                          .references(include_list)
                          .where(search_condition)
                          .where(:interviews => {:id => i_interview_id})
                          .order(order_condition)
                          .page(table_params.i_page)
                          .per(table_params.i_page_count);

    time_slots_list = time_slots;

    return ({
      :now => table_params.i_page,
      :total => time_slots.total_count,
      :show => time_slots_list
    });
  end


  def remaining
    vacancy = self.interview.vacancy;
    remaining = self.interviewees.count();

    return(vacancy - remaining);
  end


  def get_related_manager(interview = nil)
    i_interview_id = self.interview_id;

    if (interview.blank?)
      interview = Interview.find_by_id(i_interview_id);
    end

    i_procedure_id = interview.round.procedure_id;

    procedure = Procedure.find_by_id(i_procedure_id);

    i_year_id = procedure.year_id;


    users = [];
    emails = [];

    total_role_mgrs = [];
    total_location_mgrs = [];
    #total_apply_position_users = [];

    admins = User.where(:is_admin => true)
                 .where(:year_id => i_year_id);

    procedure_mgrs = User.joins(:procedure_mgrs)
                         .where(:procedure_mgrs => {:procedure_id => i_procedure_id});

    b_would_send_mail_to_mgrs_which_related_role_location = true;
    b_would_send_mail_to_mgrs_which_related_location = true;
    b_would_send_mail_to_mgrs_which_related_role = false;

    if (b_would_send_mail_to_mgrs_which_related_role_location)
      positions = Position.joins(:positions_in_interviews)
                          .where(:positions => {:procedure_id => i_procedure_id})
                          .where(:positions_in_interviews => {:interview_id => i_interview_id});

      positions.each do |position|
        if (b_would_send_mail_to_mgrs_which_related_location)
          location_mgrs = User.joins(:location_mgrs)
                              .where(:location_mgrs => {:location_id => position.location_id});

          total_location_mgrs = (total_location_mgrs | location_mgrs);
        end

        if (b_would_send_mail_to_mgrs_which_related_role)
          role_mgrs = User.joins(:role_mgrs)
                          .where(:role_mgrs => {:role_id => position.role_id});

          total_role_mgrs = (total_role_mgrs | role_mgrs);
        end
      end
    end

    users = admins | procedure_mgrs | total_location_mgrs | total_role_mgrs;
    emails = users.collect{|user| user.email};

    return (emails);
  end


end
