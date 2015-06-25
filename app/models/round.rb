class Round < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure;
  has_many :interviews;
  has_many :interviewers, :through => :interviews;
  has_many :time_slots, :through => :interviews;
  has_many :round_tags;


  def self.create_round(s_title, t_start, t_end, i_procedure_id)
    error_code = 'xSYS00000';
    success = false;

    round = Round.create(:procedure_id => i_procedure_id, :title => s_title, :t_start => t_start, :t_end => t_end);


    logger.info("# #{Time.now}, class Round create, round #{round}");
    if (round.blank?)
      error_code = 'xDBI00005';
      logger.info("# #{Time.now}, class Round create, create fail, error_code: #{error_code}");
    else
      interview_step = ProcedureStep.where(:procedure_id => i_procedure_id, :name => 'Interview').first;
      if (interview_step.present?)

        procedure_sub_step = ProcedureSubStep.create(:procedure_step_id => interview_step[:id],
                                :rank => round[:id],
                                :enabled => 1,
                                :user_view => 1,
                                :name => round[:title],
                                :identify_name => 'interview' + round[:id].to_s,
                                :url_acronym => round[:id],
                                :t_start => round[:t_start],
                                :t_end => round[:t_end]
        );


        if (procedure_sub_step.present?)
          logger.info("# #{Time.now}, class Round, procedure_sub_step #{procedure_sub_step.to_json}");
          success = true;
        else
          error_code = 'xDBI00007';
          logger.info("# #{Time.now}, class Round, create procedure_sub_step fail #{procedure_sub_step}, error_code: #{error_code}");
        end
      else
        error_code = 'xSYS00001';
        logger.info("# #{Time.now}, class Round, procedure_step loss 'Interview', error_code: #{error_code}");
      end
    end

    return {:success => success, :error_code => error_code, :round => round};
  end


  def update_round(s_title, t_start, t_end, i_select_location_ids, i_select_role_ids)
    error_code = 'xSYS00000';
    success = false;

    i_procedure_id = self.procedure_id;
    i_round_id = self.id;
    procedure = Procedure.find_by_id(i_procedure_id);

    if (procedure.present?)
      #interview_step = ProcedureStep.where(:procedure_id => i_procedure_id, :name => 'Interview').first;

      procedure_step = nil;
      if (self.erasable)
        # Interview step
        procedure_step = ProcedureStep.where(:procedure_id => i_procedure_id)
                                                .where(:name => 'Interview')
                                                .first;

      else
        # Post Match step
        procedure_step = ProcedureStep.where(:procedure_id => i_procedure_id)
                                                .where(:name => 'Post Match')
                                                .first;
      end

      if (procedure_step.present?)
        sub_step_identify_name = 'interview' + self.id.to_s;

        interview_sub_step = ProcedureSubStep.where(:procedure_step_id => procedure_step.id, :identify_name => sub_step_identify_name).first;

        if (interview_sub_step.present?)

          if (interview_sub_step.check_during_time_arg_utc_zone(t_start, t_end))
            self.title = (self.erasable)? s_title : self.title;
            self.t_start = t_start;
            self.t_end = t_end;
            interview_sub_step.name = s_title;
            self.save;
            interview_sub_step.save;
            success = true;
            logger.info("# #{Time.now},  action: Round update_round, procedure_sub_step, update success. round: #{self.to_json}");

            remove_round_location_tags = RoundTag.where(:round_id => i_round_id)
                                                 .where.not(:location_id => i_select_location_ids)
                                                 .where(:role_id => nil);

            remove_round_role_tags = RoundTag.where(:round_id => i_round_id)
                                                 .where(:location_id => nil)
                                                 .where.not(:role_id => i_select_role_ids);

            remove_round_location_tags.destroy_all;
            remove_round_role_tags.destroy_all;

            round_tag_location_ids = RoundTag.where(:round_id => i_round_id)
                                             .where.not(:location_id => nil)
                                             .pluck(:location_id);

            round_tag_role_ids = RoundTag.where(:round_id => i_round_id)
                                         .where.not(:role_id => nil)
                                         .pluck(:role_id);

            create_tag_location_ids = i_select_location_ids - round_tag_location_ids;
            create_tag_role_ids = i_select_role_ids - round_tag_role_ids;

            if (create_tag_location_ids.present?)
              create_tag_location_ids.each do |location_id|
                RoundTag.create(
                  :round_id => i_round_id,
                  :location_id => location_id
                );
              end
            end

            if (create_tag_role_ids.present?)
              create_tag_role_ids.each do |role_id|
                RoundTag.create(
                  :round_id => i_round_id,
                  :role_id => role_id
                );
              end
            end

          else
            error_code = 'xSYS00008';
            logger.info("# #{Time.now},  action: Round update_round, new round time is not during the process sub step, error_code: #{error_code}");
          end
        else
          error_code = 'xSYS00007';
          logger.info("# #{Time.now},  action: Round update_round, loss procedure_sub_step #{sub_step_identify_name}, error_code: #{error_code}");
        end

      else
        error_code = 'xSYS00001';
        logger.info("# #{Time.now},  action: Round update_round, procedure_step loss 'Interview', error_code: #{error_code}");
      end
    else
      error_code = 'xSYS00004';
      logger.info("# #{Time.now},  action: Round update_round, can't find this procedure, error_code: #{error_code}");
    end



    return {:success => success, :error_code => error_code};
  end

  def self.new_round(i_procedure_id, s_title, t_start, t_end)
    round = Round.new(
      :procedure_id => i_procedure_id,
      :title => s_title,
      :t_start => t_start,
      :t_end => t_end
    );
    round.save();
    return (round.id);
  end

  def self.get_all_round_list(table_params)
    field_map={
      "title"=> "procedures.name",
      "start"=> "positions.name",
      "end"=> "locations.name"
    };

    search_field = ['rounds.title'];

    order_condition = table_params.us_order_by.blank? ? 'rounds.title ASC' : ("%s %s" % [field_map[table_params.us_order_by], table_params.s_asc_or_desc]);
    search_condition = RsasTools.get_where_search_condition(search_field, table_params.us_search_text);

    include_list = [:round_tags =>[:role, :location]]
    rounds = Round.includes(include_list)
                  .where("rounds.procedure_id" => table_params.i_procedure_id)
                  .where(search_condition)
                  .order(order_condition)
                  .page(table_params.i_page)
                  .per(table_params.i_page_count);

    rounds_as_json = rounds.as_json({
      :include => [
        {
          :round_tags => {
            :include => [
              :role,
              :location
            ]
          }
        }
      ]
    });

    return ({
      :now => table_params.i_page,
      :total => rounds.total_count,
      :show => rounds_as_json
    });

  end


  def get_round_interviews
    round_interviews = self.as_json({
      :include => [
        :interviews,
        :round_tags => {
          :include => [
            :role,
            :location
          ]
        }
      ]
    });

    return (round_interviews);
  end

  def get_round_interview_time_slots
    round_interviews = self.as_json({
      :include => [{
        :interviews => {
          :include => [
            :interviewers,
            :time_slots
          ]
        }
      }]
    });
  end

  def is_in_active_time(user_id)
    t_start = self.t_start - 16.hours;
    t_end = self.t_end - 16.hours;
    t_now = Time.now;

    white_list = nil
    if user_id.present?
      white_list = ApplyWhiteList.where(:procedure_id => self.procedure_id, :user_id => user_id).first
    end
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    #logger.info("t_start: #{t_start}, t_end: #{t_end}, t_now: #{t_now}");
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

    if white_list
      return true
    else
      return ((t_start < t_now) && (t_end > t_now));
    end
  end

  def self.is_related_interviewer(i_round_id, i_user_id)
    interviews = Interview.joins(:interviewers)
                          .where(:interviewers => {:user_id => i_user_id})
                          .where(:round_id => i_round_id);

    is_related = (interviews.present?)? true : false;

    return (is_related);
  end

  def self.is_related_applicant(i_round_id, i_user_id)
    interviews = Interview.joins(:invites)
                          .where(:invites => {:invitee_user_id => i_user_id})
                          .where(:round_id => i_round_id);

    is_related = (interviews.present?)? true : false;

    return (is_related);
  end

  def self.check_round_permission_by_id(i_user_id, i_round_id, b_admin = false, b_hiring_mgr = false)
    round = Round.find_by_id(i_round_id);

    result = (round.present?)? round.check_round_permission(i_user_id, b_admin, b_hiring_mgr) : false;

    return (result);
  end

  def check_round_permission(i_user_id, b_admin = false, b_hiring_mgr = false)
    i_round_id = self.id;
    i_procedure_id = self.procedure_id;

    b_result = false;

    if (b_admin || b_hiring_mgr || Round.is_related_interviewer(i_round_id, i_user_id))
      b_result = true;
    else
      round_tag_location_ids = RoundTag.where(:round_id => i_round_id)
                                       .where.not(:location_id => nil)
                                       .pluck(:location_id);

      round_tag_role_ids = RoundTag.where(:round_id => i_round_id)
                                   .where.not(:role_id => nil)
                                   .pluck(:role_id);

      manage_location_ids = LocationMgr.where(:user_id => i_user_id)
                                       .pluck(:location_id);

      manage_role_ids = RoleMgr.where(:user_id => i_user_id)
                               .pluck(:role_id);

      b_has_location = (round_tag_location_ids & manage_location_ids).present?;
      b_has_role = (round_tag_role_ids & manage_role_ids).present?;
      b_result = (b_has_location | b_has_role);
    end

    return (b_result);
  end
end
















