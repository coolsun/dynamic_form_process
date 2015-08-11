class RoundsController < ApplicationController
  before_action :set_round, only: [:update, :destroy]


####################################################################################################
  def create
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_rounds")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    error_code = 'xSYS00000';
    success = false;
    #######################################################
    # need check connect usr is admin which access to manage
    #######################################################
    logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController create, params: #{params}");


    us_title = params[:title];
    time_parse_start = Time.parse(params[:time][:start]);
    time_parse_end = Time.parse(params[:time][:end]);
    i_procedure_id = params[:processId].to_i;

    us_select_location_ids = params[:selectLocationIds];
    us_select_role_ids = params[:selectRoleIds];

    i_select_location_ids = [];
    i_select_role_ids = [];
    if us_select_location_ids.present?
      i_select_location_ids = RsasTools.arr_attr_to_int(us_select_location_ids);
    end

    if us_select_role_ids.present?
      i_select_role_ids = RsasTools.arr_attr_to_int(us_select_role_ids);
    end

    interview_step =  ProcedureStep.where(:procedure_id => i_procedure_id)
                                   .where(:name => 'Interview')
                                   .first;

    if (interview_step.check_during_time_arg_utc_zone(time_parse_start, time_parse_end))
      result = Round.create_round(us_title, time_parse_start, time_parse_end, i_procedure_id);
      round = result[:round];
      success = result[:success];
      error_code = result[:error_code];

      if (success)
        i_round_id = round.id;

        if i_select_location_ids.present?
          i_select_location_ids.each do |id|
            RoundTag.create(
              :round_id => i_round_id,
              :location_id => id
            );
          end
        end

        if i_select_role_ids.present?
          i_select_role_ids.each do |id|
            RoundTag.create(
              :round_id => i_round_id,
              :role_id => id
            );
          end
        end

      end
    else
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController create, round's time is not during interview step time.");
      error_code = 'xSYS00010';
    end

    render :json => {
      :success => success,
      :eCode => error_code
    }

  end

####################################################################################################
  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_rounds")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    success = false;
    error_code = 'xSYS00000';

    if (@round.present?)
      us_title = params[:title];
      time_parse_start = Time.parse(params[:time][:t_start]);
      time_parse_end = Time.parse(params[:time][:t_end]);
      us_select_location_ids = params[:selectLocationIds];
      us_select_role_ids = params[:selectRoleIds];

      i_select_location_ids = [];
      i_select_role_ids = [];
      if us_select_location_ids.present?
        i_select_location_ids = RsasTools.arr_attr_to_int(us_select_location_ids);
      end

      if us_select_role_ids.present?
        i_select_role_ids = RsasTools.arr_attr_to_int(us_select_role_ids);
      end


      result = @round.update_round(us_title, time_parse_start, time_parse_end, i_select_location_ids, i_select_role_ids);
      success = result[:success];
      error_code = result[:error_code];

    else
      error_code = 'xSYS00002';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController update, round:#{params[:id]} delete fail, error_code: #{error_code}");
    end

    render :json => {
      :success => success,
      :eCode => error_code
    }
  end

####################################################################################################
  def destroy
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_rounds")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    error_code = 'xSYS00000';
    success = true;

    if (@round && @round.erasable)
      interviews = Interview.where(:round_id => @round[:id])
      if (interviews.present?)
        success = false;
        error_code = 'xDBD00004';
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController destroy, round:#{params[:id]} delete fail, error_code: #{error_code}");
      else
        identify_name = 'interview' + @round.id.to_s;
        procedure_sub_step = ProcedureSubStep.find_by_identify_name(identify_name);
        @round.destroy;
        procedure_sub_step.destroy;
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController destroy, round:#{@round[:id]} delete success");
      end


    else
      success = false;
      error_code = 'xSYS00002';
      logger.info("# #{Time.now} IP:#{request.remote_ip}, action: RoundsController destroy, round:#{params[:id]} delete fail, error_code: #{error_code}");
    end

    render :json => {
      :success => success,
      :eCode => error_code
    }
  end # def destroy


####################################################################################################
  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("set_up_rounds")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    table_params = rsas_table_params();
    response = {};


    data = Round.get_all_round_list(table_params);

    response = {
      :success => true,
      :now => data[:now],
      :total => data[:total],
      :show => data[:show],
      :permission_to_active => permission_to_active
    };

    #logger.info(response);

    render :json => response;
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find_by_id(params[:id])
    end
end
