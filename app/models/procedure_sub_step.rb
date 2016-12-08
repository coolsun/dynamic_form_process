class ProcedureSubStep < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure_step;

  def t_start_string
    #return self.t_start.kind_of?(Time) ? self.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M %p") : ""
    return self.t_start.kind_of?(Time) ? (self.t_start - 8.hours).strftime("%m/%d/%Y %I:%M %p") : ""
  end

  def t_end_string
    #return self.t_end.kind_of?(Time) ? self.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M %p") : ""
    return self.t_end.kind_of?(Time) ? (self.t_end - 8.hours).strftime("%m/%d/%Y %I:%M %p") : ""
  end

  def t_start_string_for_landing
    self.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %I:%M %p")
  end

  def t_end_string_for_landing
    self.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y, %I:%M %p")
  end

  def t_start_string=(string)
    self.t_start = Time.strptime(string + " PST", "%m/%d/%Y %I:%M %p %z") if string.present?
  end

  def t_end_string=(string)
    self.t_end = Time.strptime(string + " PST", "%m/%d/%Y %I:%M %p %z") if string.present?
  end

  def self.is_in_active_time(procedure_id, identify_name, user_id)
    sub_step = ProcedureSubStep.joins(:procedure_step).where(:procedure_steps => {:procedure_id => procedure_id}, :identify_name => identify_name).first

    white_list = nil
    if user_id.present?
      white_list = ApplyWhiteList.where(:procedure_id => procedure_id, :user_id => user_id).first
    end

    if white_list
      return true
    elsif sub_step.t_start && sub_step.t_end
      return (sub_step.t_start < Time.now && Time.now < sub_step.t_end)
    else
      return false
    end
  end



  def self.rebuild_post_interview(i_procedure_id)
    error_code = 'xSYS99999';
    success = false;

    post_interview_sub_step = ProcedureSubStep.joins(:procedure_step => [:procedure])
                                              .where(:procedures => {:id => i_procedure_id})
                                              .where(:procedure_steps => {:name => 'Post Match'})
                                              .where(:procedure_sub_steps => {:name => 'Post Match Interview'})
                                              .first;

    if (post_interview_sub_step.present?)
      round = Round.create(
       :procedure_id => i_procedure_id,
       :title => 'Post Match Interview',
       :t_start => post_interview_sub_step.t_start,
       :t_end => post_interview_sub_step.t_end,
       :erasable => false
      );

      logger.info("# #{Time.now}, class Round rebuild_post_interview, round #{round}");
      if (round.blank?)
        error_code = 'xDBI00005';
        logger.info("# #{Time.now}, class ProcedureSubStep rebuild_post_interview, create round fail, error_code: #{error_code}");
      else
        identify_name = 'interview' + (round.id).to_s;
        post_interview_sub_step.identify_name = identify_name;
        post_interview_sub_step.save!;

        success = true;
        error_code = 'xSYS00000';
        logger.info("# #{Time.now}, class ProcedureSubStep rebuild_post_interview, success.");
      end
    else
      error_code = 'xSYS00007';
      logger.info("# #{Time.now}, class ProcedureSubStep rebuild_post_interview, fail, can't find this procedure_sub_step, error_code: #{error_code}");
    end

    return {:success => success, :error_code => error_code};
  end


  def check_during_time_arg_utc_zone(t_start, t_end)
    sub_step_start_time = self.t_start;
    sub_step_end_time = self.t_end;

    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    #logger.info("sub_step_start_time : #{sub_step_start_time}");
    #logger.info("sub_step_end_time   : #{sub_step_end_time}");
    #logger.info("t_start             : #{t_start}");
    #logger.info("t_end               : #{t_end}");
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

    rm_sec_sub_step_start_time = Time.parse(sub_step_start_time.strftime("%Y/%m/%d %I:%M %p"));
    rm_sec_sub_step_end_time = Time.parse(sub_step_end_time.strftime("%Y/%m/%d %I:%M %p"));
    rm_sec_start_time = Time.parse(t_start.strftime("%Y/%m/%d %I:%M %p"));
    rm_sec_end_time = Time.parse(t_end.strftime("%Y/%m/%d %I:%M %p"));

    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    #logger.info("rm_sec_sub_step_start_time : #{rm_sec_sub_step_start_time}");
    #logger.info("rm_sec_sub_step_end_time   : #{rm_sec_sub_step_end_time}");
    #logger.info("rm_sec_start_time          : #{rm_sec_start_time}");
    #logger.info("rm_sec_end_time            : #{rm_sec_end_time}");
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

    return ((rm_sec_sub_step_start_time <= rm_sec_start_time) && (rm_sec_sub_step_end_time >= rm_sec_end_time));
  end



end
