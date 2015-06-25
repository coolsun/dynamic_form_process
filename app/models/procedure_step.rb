class ProcedureStep < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure;
  has_many :procedure_sub_steps, :dependent => :destroy;

  def t_start_string
    self.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M")
  end

  def t_end_string
    self.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M")
  end

  def t_start_string_for_landing
    self.t_start.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y,%l:%M %p")
  end

  def t_end_string_for_landing
    self.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y,%l:%M %p")
  end

  def t_start_string=(string)
    self.t_start = Time.strptime(string + " PST", "%m/%d/%Y %H:%M %Z")
  end

  def t_end_string=(string)
    self.t_end = Time.strptime(string + " PST", "%m/%d/%Y %H:%M %Z")
  end

  def self.get_procedure_steps_list(where_condition)
    return ProcedureStep.includes(:procedure_sub_steps).where(where_condition).order(["procedure_steps.rank asc", "procedure_sub_steps.rank asc"])
                        .as_json({:include => {:procedure_sub_steps => {:methods => [:t_start_string, :t_end_string]}}, :methods => [:t_start_string, :t_end_string]})
  end

  def is_in_active_time(user_id)
    white_list = nil
    if user_id.present?
      white_list = ApplyWhiteList.where(:procedure_id => self.procedure_id, :user_id => user_id).first
    end

    if white_list
      return true
    elsif self.t_start && self.t_end
      return (self.t_start < Time.now && Time.now < self.t_end)
    else
      return false
    end
  end

  def check_during_time_arg_utc_zone(t_start, t_end)
    step_start_time = self.t_start;
    step_end_time = self.t_end;

    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    #logger.info("sub_step_start_time : #{sub_step_start_time}");
    #logger.info("sub_step_end_time   : #{sub_step_end_time}");
    #logger.info("t_start             : #{t_start}");
    #logger.info("t_end               : #{t_end}");
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

    rm_sec_step_start_time = Time.parse(step_start_time.strftime("%Y/%m/%d %H:%M"));
    rm_sec_step_end_time = Time.parse(step_end_time.strftime("%Y/%m/%d %H:%M"));
    rm_sec_start_time = Time.parse(t_start.strftime("%Y/%m/%d %H:%M"));
    rm_sec_end_time = Time.parse(t_end.strftime("%Y/%m/%d %H:%M"));

    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    #logger.info("rm_sec_sub_step_start_time : #{rm_sec_sub_step_start_time}");
    #logger.info("rm_sec_sub_step_end_time   : #{rm_sec_sub_step_end_time}");
    #logger.info("rm_sec_start_time          : #{rm_sec_start_time}");
    #logger.info("rm_sec_end_time            : #{rm_sec_end_time}");
    #logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

    return ((rm_sec_step_start_time <= rm_sec_start_time) && (rm_sec_step_end_time >= rm_sec_end_time));
  end



end
