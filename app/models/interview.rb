class Interview < ActiveRecord::Base
  has_paper_trail

  include RsasTools

  belongs_to :round;
  has_many :invites
  has_many :invitees, :through => :invites;
  has_many :inviters, :through => :invites;
  has_many :interviewers;
  has_many :users, :through => :interviewers;
  has_many :positions_in_interviews;
  has_many :positions, :through => :positions_in_interviews;
  has_many :time_slots;
  has_many :interviewees, :through => :time_slots;

  attr_accessor :i_user_id;

  def self.set_attr_user_id(i_user_id)
    @@i_user_id = i_user_id;
  end

####################################################################################################
  def self.new_interview(i_round_id, i_vacancy, s_name, b_one_time_slot_per_applicant, b_interviewer_can_edit, b_interviewer_can_schedule, i_interviewer_vacancy, i_max_time_slot_per_interviewer)

    interview = Interview.create(
      :round_id => i_round_id,
      :vacancy => i_vacancy,
      :name => s_name,
      :one_time_slot_per_applicant => b_one_time_slot_per_applicant,
      :interviewer_can_edit => b_interviewer_can_edit,
      :interviewer_can_schedule => b_interviewer_can_schedule,
      :interviewer_vacancy => i_interviewer_vacancy,
      :max_time_slot_per_interviewer => i_max_time_slot_per_interviewer
    );

    return (interview);
  end

####################################################################################################
  def self.admin_get_interviews(table_params, i_round_id, i_user_id, b_senior_manager)
    field_map={
      "Interview"=> "interviews.name",
      "Vacancy"=> "interviews.vacancy"
    };

    search_field = ['roles.name', 'locations.name', 'positions.tag', 'interviews.name'];

    #order_condition = table_params.us_order_by.blank? ? 'interviews.name ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);

    round_obj = Round.find_by_id(i_round_id);
    b_do = (round_obj.procedure_id == table_params.i_procedure_id);

    interviews = [];
    if (b_senior_manager && b_do)
      include_list = [
                      :time_slots,
                      :positions_in_interviews => [
                        {
                          :position => [
                            :role,
                            :location
                          ]
                        }
                      ]
                     ];  # :procedure


      interviews = Interview.includes(include_list)
                            .where(:interviews => {:round_id => i_round_id})
                            .where(search_condition)
                            .order("time_slots.t_start ASC")
                            .page(table_params.i_page)
                            .per(table_params.i_page_count);


                            #.where(:rounds => {:procedure_id => table_params.i_procedure_id})
                            #.where(:rounds => {:id => i_round_id})

                            #.order("interviews.id ASC")
    end


    interviews_list = interviews.as_json({
      :include => [
        {
          :time_slots => {
            :include => [
              {
                :interviewees => {
                  :include => {
                    :user => {
                      :methods => :name
                    }
                  }
                }
              },
              {
                :time_slot_interviewers => {
                  :include => {
                    :interviewer => {
                      :include => {
                        :user => {
                          :methods => :name
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        },
        {
          :positions_in_interviews => {
            :include => [
              :position
            ]
          }
        }
      ]
    });

    return ({
      :now => table_params.i_page,
      :total => interviews.total_count,
      :show => interviews_list
    });

  end

####################################################################################################
  def self.admin_get_interviews_limited_by_position(table_params, i_round_id, i_user_id, b_senior_manager, b_middle_manager)

    field_map={
      "Interview"=> "interviews.name",
      "Vacancy"=> "interviews.vacancy"
    };

    search_field = ['roles.name', 'locations.name', 'positions.tag', 'interviews.name'];

    #order_condition = table_params.us_order_by.blank? ? 'interviews.name ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);


    round_obj = Round.find_by_id(i_round_id);
    b_do = (round_obj.procedure_id == table_params.i_procedure_id);

    user_obj = User.find_by_id(i_user_id);
    result = Interview.get_mgr_interviews(round_obj, user_obj);

    view_interview_ids = result.view_interview_ids;
    interviewer_interview_ids = result.interviewer_interview_ids

    interviews = [];
    if (b_senior_manager)

    elsif (b_do)
      include_list = [
                      :time_slots => [
                      ],
                      :positions_in_interviews => [
                        {
                          :position => [
                            :role,
                            :location
                          ]
                        }
                      ]
                     ];  # :procedure

      interviews = Interview.includes(include_list)
                            .where(:round_id => i_round_id)
                            .where(search_condition)
                            .where(:interviews => {:id => view_interview_ids})
                            .order("time_slots.t_start ASC")
                            .page(table_params.i_page)
                            .per(table_params.i_page_count);


                            #.where(:rounds => {:procedure_id => table_params.i_procedure_id})
                            #.where(:rounds => {:id => i_round_id})
    end

    interviews_list = interviews.as_json({
      :include => [
        {
          :time_slots => {
            :include => [
              {
                :interviewees => {
                  :include => {
                    :user => {
                      :methods => :name
                    }
                  }
                }
              },
              {
                :time_slot_interviewers => {
                  :include => {
                    :interviewer => {
                      :include => {
                        :user => {
                          :methods => :name
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        },
        {
          :positions_in_interviews => {
            :include => [
              :position => {
                :include => [
                  :role,
                  :location
                ]
              }
            ]
          }
        }
      ]
    });

    i_interview_total_count = interviews.total_count;
    interviews = nil;
    GC.start();

    logger.info("i_user_id : #{i_user_id}");

    interviews_list.each do |interview|
      i_interview_id = interview["id"];
      b_include = interviewer_interview_ids.include?(i_interview_id)

      if (b_include)
        interview["only_interviewer"] = true;
      end
    end

    return ({
      :now => table_params.i_page,
      :total => i_interview_total_count,
      :show => interviews_list
    });


  end

####################################################################################################
  def check_interview_permision(user)
    i_interview_id = self.id;
    i_user_id = user.id;
    interview_position_ids = self.positions.pluck(:id)

    time_slot_interviewer = TimeSlotInterviewer.joins(:interviewer)
                                               .where(:interviewers => {:user_id => i_user_id})
                                               .where(:interviewers => {:interview_id => i_interview_id});

    b_scheduled_interviewer = false;
    b_mgr_interview = false;
    if (time_slot_interviewer.present?)
      b_scheduled_interviewer = true;
    else
      position_ids = [];
      user.locations.each do |location|
        position_ids |= location.positions.pluck(:id);
      end

      user.roles.each do |role|
        position_ids |= role.positions.pluck(:id);
      end

      mgr_interview_position_ids = position_ids & interview_position_ids

      b_mgr_interview = (interview_position_ids.length == mgr_interview_position_ids.length);
    end

    return OpenStruct.new({
      :b_view => (b_scheduled_interviewer || b_mgr_interview),
      :b_scheduled_interviewer => b_scheduled_interviewer
    });

  end

####################################################################################################
  def self.get_mgr_interviews(round, user)
    view_interview_ids = [];
    interviewer_interview_ids =[];

    round.interviews.each do |interview|
      result = interview.check_interview_permision(user);

      view_interview_ids << interview.id if result.b_view
      interviewer_interview_ids << interview.id if result.b_scheduled_interviewer
    end

    return OpenStruct.new({
      :view_interview_ids => view_interview_ids,
      :interviewer_interview_ids => interviewer_interview_ids
    })
  end

####################################################################################################
  def self.admin_get_my_interviews(table_params, i_round_id, i_user_id)
    field_map={
      "Interview"=> "interviews.name",
      "Vacancy"=> "interviews.vacancy"
    };

    search_field = ['roles.name', 'locations.name', 'positions.tag', 'interviews.name'];

    order_condition = table_params.us_order_by.blank? ? 'interviews.name ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    include_list = [
                    #:round,
                    :interviewers,
                    :time_slots => [
                      :time_slot_interviewers,
                      :interviewees => [
                        :user
                      ]
                    ],
                    :positions_in_interviews => [
                      {
                        :position => [
                          :role,
                          :location
                        ]
                      }
                    ]
                   ];  # :procedure


    round_obj = Round.find_by_id(i_round_id);
    b_do = (round_obj.procedure_id == table_params.i_procedure_id);


    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);
    interviews = [];
    #i_interview_total = 0;

    #if (0 < table_params.i_procedure_id)
    if (b_do)
      interviews = Interview.includes(include_list)
                            .references(include_list)
                            .where(:round_id => i_round_id)
                            .where(:interviewers => {:user_id => i_user_id})
                            .where(search_condition)
                            .order(order_condition)
                            .order("time_slots.t_start ASC")
                            .page(table_params.i_page)
                            .per(table_params.i_page_count);
                            # .where("procedures.id" => table_params.i_procedure_id)
                            # .where("positions.procedure_id" => table_params.i_procedure_id)
                            # .where("locations.procedure_id" => table_params.i_procedure_id)
                            # .where("roles.procedure_id" => table_params.i_procedure_id)
                            # .order("time_slots.t_start ASC")
                            # .order(order_condition)
                            # .order("interviews.id ASC")
                            # .where("interviews.id IN (SELECT DISTINCT(INTERVIEW_ID) FROM POSITIONS_IN_INTERVIEWS)")
    end




    interviews_list = interviews.as_json({
      :include => [
        #:round,
        {
          :time_slots => {
            :include => [
              :time_slot_interviewers,
              {
                :interviewees => {
                  :include => [
                    :user => {
                      :methods => :name
                    }
                  ]
                }
              }
            ]
          }
        },
        {
          :positions_in_interviews => {
            :include => [
              :position
            ]
          }
        },
        :interviewers
      ]
    });

    if (interviews_list.present?)
      interviews_list.each do |interview|
        if (interview["time_slots"].present? && interview["interviewers"])
          interview["time_slots"].each do |time_slot|
            if (time_slot["time_slot_interviewers"].present?)
              time_slot["time_slot_interviewers"].each do |time_slot_interviewer|
                interview["interviewers"].each do |interviewer|
                  if (interviewer["id"] == time_slot_interviewer["interviewer_id"])
                    time_slot["check"] = true;
                    break;
                  end
                end
                if (true == time_slot["check"])
                  break;
                end
              end

              interviewer_ids = time_slot["time_slot_interviewers"].collect{|time_slot_interviewer| time_slot_interviewer["interviewer_id"]};

              interviewer_users = User.joins(:interviewers)
                                      .where(:interviewers => {:id => interviewer_ids});

              time_slot["interviewer_users"] = interviewer_users.as_json({
                :methods => :name
              });

            end
          end
        end
      end
    end

    return ({
      :now => table_params.i_page,
      :total => interviews.total_count,
      :show => interviews_list
    });

  end # def self.admin_get_my_interviews(table_params, i_round_id, i_user_id)

####################################################################################################
  def self.get_interviewers(i_interview_id, i_year_id)
    interviewers = [];
    # procedure_mgrs
    # location_mgrs
    # role_mgrs
    # but user is not applicant at this position

    interview = Interview.find_by_id(i_interview_id);

    if (interview)
      round = Round.find_by_id(interview.round_id);

      if (round)
        i_procedure_id = round.procedure_id;

        positions = Position.joins(:positions_in_interviews)
                            .where(:positions => {:procedure_id => i_procedure_id})
                            .where(:positions_in_interviews => {:interview_id => i_interview_id});

        users = [];
        submited_applicants = [];
        total_role_mgrs = [];
        total_location_mgrs = [];
        #total_apply_position_users = [];

        admins = User.where(:is_admin => true)
                     .where(:year_id => i_year_id);

        procedure_mgrs = User.joins(:procedure_mgrs)
                             .where(:procedure_mgrs => {:procedure_id => i_procedure_id});

        positions.each do |position|
          location_mgrs = User.joins(:location_mgrs)
                              .where(:location_mgrs => {:location_id => position.location_id});
          #logger.info("location_mgrs: #{location_mgrs.to_json}");

          role_mgrs = User.joins(:role_mgrs)
                          .where(:role_mgrs => {:role_id => position.role_id});
          #logger.info("role_mgrs #{role_mgrs.to_json}");

          #apply_position_users = User.joins(:applications)
          #                           .where(:applications => {:position_id => position.id});

          #logger.info("apply_position_users #{apply_position_users.to_json}");


          total_location_mgrs = (total_location_mgrs | location_mgrs);
          total_role_mgrs = (total_role_mgrs | role_mgrs);
          #total_apply_position_users = (total_apply_position_users | apply_position_users);

        end

        submited_applicants = User.joins(:applicants)
                                  .where(:applicants => {:procedure_id => i_procedure_id})
                                  .where.not(:applicants => {:application_submit_at => nil});

        #users = (admins | procedure_mgrs | total_location_mgrs | total_role_mgrs) - total_apply_position_users;
        users = (admins | procedure_mgrs | total_location_mgrs | total_role_mgrs) - submited_applicants;

        users &= users;

        interviewer_inner_users = User.get_users_inner_interviewer_by_interview_id(i_interview_id);

        # this can optimize, but maybe loss sequence, or use binary optimize.
        users.each do |user|
          b_is_interviewer = false;
          interviewer_inner_users.each do |interviewer|
            if (user.id == interviewer.id)
              b_is_interviewer = true;
              break;
            end
          end
          user_hash = user.as_json;
          user_hash[:name] = user.name;
          user_hash[:check] = b_is_interviewer;
          interviewers << user_hash;

          #interviewers << {
          #  :id => user.id,
          #  :name => user.name,
          #  :suid => user.suid,
          #  :check => b_is_interviewer
          #}
        end
      end
    end

    return (interviewers);
  end

####################################################################################################
  def self.get_sunet_interviewers(i_interview_id)
    interviewers = [];

    interview = Interview.find_by_id(i_interview_id);

    if (interview)
      user = User.includes(:interviewers)
                 .where(:interviewers => {:interview_id => interview.id})
                 .where(:interviewers => {:is_by_sunet_id => true});

      interviewers = user.as_json({
        :methods => :name
      });
    end

    return (interviewers);
  end

####################################################################################################
  def applied
    b_was_applied = false;
    i_time_slot_id = 0;
    i_interviewee_id = 0;
=begin
    self.interviewees.each do |interviewee|
      if (interviewee.user_id == @@i_user_id)
        b_was_applied = true;
        interviewee_id = interviewee.id;
        break;
      end
    end
=end

    self.time_slots.each do |time_slot|
      time_slot.interviewees.each do |interviewee|
        if (interviewee.user_id == @@i_user_id)
          b_was_applied = true;
          i_time_slot_id = time_slot.id;
          i_interviewee_id = interviewee.id;
        end
      end
    end


    return ({:isApplied => b_was_applied, :intervieweeId => i_interviewee_id, :timeSlotId => i_time_slot_id})
  end

####################################################################################################
  def self.user_get_interviews(i_user_id, table_params, i_round_id)
    user_interviews = [];
    @@i_user_id = i_user_id;

    field_map={
      "Interview"=> "interviews.name"
    };

    search_field = ['roles.name', 'locations.name', 'interviews.name'];

    order_condition = table_params.us_order_by.blank? ? 'interviews.name ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    include_list = [
      :round,
      :invites,
      :time_slots,
      :positions_in_interviews => [
        {
          :position => [
            :role,
            :location
          ]
        }
      ]
    ];

    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);

    interviews = nil;
    #i_interview_total = 0;

    interviews = Interview.includes(include_list)
                          .references(include_list)
                          .where(:rounds => {:procedure_id => table_params.i_procedure_id})
                          .where(:rounds => {:id => i_round_id})
                          .where(:invites => {:invitee_user_id => i_user_id})
                          .where(search_condition)
                          .order(order_condition)
                          .order("time_slots.t_start ASC")
                          .page(table_params.i_page)
                          .per(table_params.i_page_count);

    interview_list = interviews.as_json({
      :methods => :applied,
      :include => [
        {
          :time_slots => {
            :include => [
              :interviewees
            ]
          }
        },
        {
          :positions_in_interviews => {
            :include => [
              :position
            ]
          }
        }
      ]
    });

    i_interview_total_count = interviews.total_count;
    interviews = nil;
    GC.start();

=begin
    include_applied_interviews.each do |interview|
      b_push_user_interviews = true;
      interview["interviewers"].each do |interviewer|
        if (interviewer["user_id"] == i_user_id)
          b_push_user_interviews = false;
          break;
        end
      end

      if (b_push_user_interviews)
        interview.delete("interviewers");
        user_interviews << interview;
      end
    end
=end


    return ({
      :now => table_params.i_page,
      :total => i_interview_total_count,
      :show => interview_list
    });
  end

####################################################################################################
  def self.email_at_mgr_select_applicant(i_interview_id, i_mail_to_user_ids, manager_emails)
    #1
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_select_applicant")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'SignUpInterviewURL', procedure, s_interview_url);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);

        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_cancel_select_applicant(i_interview_id, i_mail_to_user_ids, manager_emails)
    #2
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_cancel_select_applicant")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_schedule_applicant(i_mail_to_user_ids, time_slot, manager_emails)
    #3
    i_interview_id = time_slot.interview_id
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_schedule_applicant")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_cancel_schedule_applicant(i_mail_to_user_ids, time_slot, manager_emails)
    #4
    i_interview_id = time_slot.interview_id
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_cancel_schedule_applicant")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_select_interviewer(i_interview_id, i_mail_to_user_ids, manager_emails)
    #5
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_select_interviewer")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'SignUpInterviewURL', procedure, s_interview_url);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_cancel_select_interviewer(i_interview_id, i_mail_to_user_ids, manager_emails)
    #6
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_cancel_select_interviewer")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_mgr_schedule_interviewer(i_mail_to_user_ids, time_slot, manager_emails)
    #7
    i_interview_id = time_slot.interview_id
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_schedule_interviewer")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end

  end

####################################################################################################
  def self.email_at_mgr_cancel_schedule_interviewer(i_mail_to_user_ids, time_slot, manager_emails)
    #8
    i_interview_id = time_slot.interview_id;
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_mgr_cancel_schedule_interviewer")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_applicant_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails)
    #9
    i_interview_id = time_slot.interview_id;
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_applicant_schedule_to_self")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_applicant_cancel_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails)
    #10
    i_interview_id = time_slot.interview_id;
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['apply_now', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_applicant_cancel_schedule_to_self")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'ApplicantName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_interviewer_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails)
    #11
    i_interview_id = time_slot.interview_id;
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_interviewer_schedule_to_self")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_at_interviewer_cancel_schedule_to_self(i_mail_to_user_ids, time_slot, manager_emails)
    #12
    i_interview_id = time_slot.interview_id;
    interview = Interview.email_get_interview_info(i_interview_id);

    if (interview)
      round = interview["round"];
      i_round_id = round["id"].to_i;
      procedure = round["procedure"];
      i_procedure_id = procedure["id"].to_i;
      s_interview_url = ("%s/%s/%d" %['process_step', 'interview', i_round_id]);

      email_template = EmailTemplate.where(:procedure_id => i_procedure_id)
                                    .where(:email_type => "interview_interviewer_cancel_schedule_to_self")
                                    .where(:is_active => true)
                                    .first;

      s_title = email_template.title;
      s_content = email_template.content;
      s_content = Interview.email_replace_interview_info(s_content, interview);
      s_content = Interview.email_replace_hiring_mgr(s_content, i_procedure_id);
      s_content = Interview.email_replace_url(s_content, 'ViewInterviewURL', procedure, s_interview_url);
      s_content = Interview.email_replace_time_slot_time(s_content, time_slot);

      i_mail_to_user_ids.each do |i_user_id|
        user = User.find_by_id(i_user_id);
        s_send_content = email_replace_dear_users(s_content, 'InterviewerName', user);
        StanfordMailer.send_shipped(user.email, s_title, s_send_content, manager_emails);

        #logger.info("s_send_content : #{s_send_content}");
      end
    end
  end

####################################################################################################
  def self.email_get_interview_info(i_interview_id)

    include_list = [:round => [:procedure], :positions_in_interviews => [{:position => [:role, :location]}]];

    interview = Interview.includes(include_list)
                         .references(include_list)
                         .where(:id => i_interview_id)
                         .first;

    interview_as_json = interview.as_json({
      :include => [
        {
          :round => {
            :include => [
              :procedure => {
                :include => [
                  :year
                ]
              }
            ]
          }
        },
        {
          :positions_in_interviews => {
            :include => [
              :position
            ]
          }
        }
      ]
    });

    return (interview_as_json);
  end

####################################################################################################
  def self.email_replace_interview_info(s_content, interview)
    round = interview["round"];
    procedure = round["procedure"];

    round_title = round["title"];
    procedure_name = procedure["name"];
    interview_name = interview["name"];

    position_names = [];

    if (interview["positions_in_interviews"].present?)
      position_names = interview["positions_in_interviews"].collect{|positions_in_interview| positions_in_interview["position"]["name"]};
    end

    s_content = s_content.gsub('[[ProcessName]]', procedure_name);
    s_content = s_content.gsub('[[Round]]', round_title);
    s_content = s_content.gsub('[[Interview]]', interview_name);
    s_content = s_content.gsub('[[Positions]]', position_names.join(", "));

    return (s_content);
  end

####################################################################################################
  def self.email_replace_hiring_mgr(s_content, i_procedure_id)
    mgrs = User.get_hiring_mgr_list(i_procedure_id);
    mgr_names = mgrs.collect{|user| user.name};
    mgr_emails = mgrs.collect{|user| user.email};

    s_content = s_content.gsub('[[HiringManagerName]]', mgr_names.join(", "));
    s_content = s_content.gsub('[[HiringManagerEmail]]', mgr_emails.join(", "));


    return (s_content);
  end

####################################################################################################
  def self.email_replace_url(s_content, s_url_replace_key_word, procedure, s_goal)
    # https://saisappdev68.stanford.edu/saas/app/index.html#/2014-2015/DEV/apply_now

    s_year = procedure['year']['name'];
    s_acronym = procedure['acronym'];
    s_path = '/saas/app/index.html#/' + s_year + '/' + s_acronym + '/' + s_goal;

    if (Rails.env == "production")
      s_domain = (procedure['domain'].present?)? procedure['domain'].to_s : 'selection.stanford.edu';
      s_target_url = 'https://' + s_domain + '/' + s_path;
    else
      if STANFORD68
        s_domain = 'saisappdev68.stanford.edu';
        s_target_url = 'https://' + s_domain + '/' + s_path;
      else
        s_domain = '184.169.165.135:8010';
        s_target_url = 'http://' + s_domain + '/' + s_path;
      end
    end

    s_b64_target_url = Base64.urlsafe_encode64(s_target_url);

    s_url = 'http://' + s_domain + '/trans_url/' + s_b64_target_url;

    key_word = "[[#{s_url_replace_key_word}]]";
    s_content = s_content.gsub(key_word, s_url);

    return (s_content);
  end

####################################################################################################
  def self.email_replace_dear_users(s_content, s_user_replace_key_word, user)
    key_word = "[[#{s_user_replace_key_word}]]";
    s_content = s_content.gsub(key_word, user.name);

    return (s_content);
  end

####################################################################################################
  def self.email_replace_time_slot_time(s_content, time_slot)
    t_start = time_slot.t_start - 8.hours;
    t_end = time_slot.t_end - 8.hours;
    s_time_during = "From " + t_start.strftime("%m/%d/%Y %H:%M") + " to " + t_end.strftime("%m/%d/%Y %H:%M");

    s_content = s_content.gsub("[[InterviewTime]]", s_time_during);

    return (s_content);
  end



end
