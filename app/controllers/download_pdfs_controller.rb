class DownloadPdfsController < ApplicationController
  require 'wicked_pdf'

  def down_load_applicants_forms
    pdf = WickedPdf.new.pdf_from_string(params[:html_string])
    send_data(pdf, :filename => "#{Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H%M")}.pdf", :type => "application/pdf", :disposition => "attachment")
  end

  def test_new_pdf
    # This line is create a PDF file likes a html page show the header1 "Hello There!"
    #pdf = WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>')

    # Test getting data from DB
    process6_form_list = Form.where(:procedure_id => 6).select(:form_name)
    @what = process6_form_list.to_json
    # Test getting data from params
    @oh = params[:oh]

    # Create a PDF file according to the view template, could show the dynamic datas
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('download_pdfs/test_new_pdf.html.erb')
    )
    # Client side download the PDF file
    send_data(pdf, :filename => "test.pdf", :type => "application/pdf")
  end

  def pdf_form
    @applicants = []
    JSON.parse(params[:selected_forms]).each do |applicant|
      obj = {}
      logger.info "== applicant #{applicant.to_json} =="
      obj["name"] = applicant["name"]
      obj["forms"] = []

      system_forms = UserForm.where(:id => applicant["system"])
      application_forms = UserForm.where(:id => applicant["application"])
      recommendation_forms = RecommendationForm.where(:id => applicant["recommendation"])
      interview_forms = InterviewEvaluateForm.where(:id => applicant["interview"])

      transcripts = nil
      transcripts = Transcript.applicant_transcripts(applicant["transcripts"].first) if User.find_by_id(session[:user_id]).is_staff && applicant["transcripts"].present?
      obj["transcripts"] = transcripts
      logger.info "== obj['transcripts'] #{obj['transcripts']} =="

      s_forms = []
      system_forms.each do |form|
        form.schema = Form.data_binding(form.schema, form.user_id, session[:user_id])
        s_forms << form
      end
      r_forms = []
      recommendation_forms.each do |form|
        r_forms << RecommendationForm.schema_add_name_relationship(form)
      end

      forms = (s_forms + application_forms + r_forms + interview_forms)
      forms.each do |user_form|
        schema = JSON.parse(user_form.schema)
        arr = []
        maxColumn = 0
        current_row = 0
        blocks = []
        schema.each do |item|
          if current_row != item["row"]
            blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
            maxColumn = 0
            arr = []
            current_row = item["row"]
          end
          maxColumn = item["column"] if item["column"] > maxColumn
          if item["type"] == "file"
            item["files"] = UploadFile.where(:user_form_id => user_form.id)
          end
          arr << OpenStruct.new(item)
        end
        blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
        logger.info "== blocks #{blocks.to_json} =="
        obj["forms"] << {"form_name" => user_form.form_name, "blocks" => blocks}
      end
      if obj["forms"].present? || obj["transcripts"].present?
        @applicants << obj
      end
    end
    @applicants.sort! { |a, b| a["name"].downcase <=> b["name"].downcase }
#=begin
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('download_pdfs/pdf_form.html.erb'),
      :footer => {:center => '[page] / [topage]'}
    )
    send_data(pdf, :filename => Time.now().in_time_zone("Pacific Time (US & Canada)").strftime("%m_%d_%Y_%H%M") + ".pdf", :type => "application/pdf")
#=end
  end


  def interview_scheduled_applicants_pdf
    @applicants = [];
    i_interview_id = params[:interviewId].to_i;
    b_system_form_check = params[:systemFormCheck];
    b_attachable_form_check = params[:attachableFormsCheck];
    b_recommendations_form_check = params[:recommendationsFormCheck];
    b_transcripts_form_check = params[:transcriptsFormCheck];

    #logger.info("i_interview_id : #{i_interview_id}");
    #logger.info("b_system_form_check : #{b_system_form_check}");
    #logger.info("b_attachable_form_check : #{b_attachable_form_check}");
    #logger.info("b_recommendations_form_check : #{b_recommendations_form_check}");
    #logger.info("b_transcripts_form_check : #{b_transcripts_form_check}");

    interview = Interview.find_by_id(i_interview_id);
    i_round_id = interview.round_id;
    s_interview_name = interview.name;
    round = Round.find_by_id(i_round_id);
    s_round_name = round.title;
    i_procedure_id = round.procedure_id;

    join_list = [:interviewees => [:time_slot => [:interview]]];

    scheduled_users = User.joins(join_list)
                          .where(:interviews => {:id => i_interview_id});

    logger.info("scheduled_users : #{scheduled_users.to_json}");

    scheduled_users.each do |user|
      i_user_id = user.id;
      s_user_name = user.name;

      obj = {}
      obj["name"] = s_user_name;
      obj["forms"] = []

      system_forms = [];
      attachable_forms = [];
      recommendation_forms = [];

      if (b_system_form_check)
        join_list = [:form];
        system_forms = UserForm.joins(join_list)
                               .where(:user_id => i_user_id)
                               .where(:procedure_id => i_procedure_id)
                               .where(:forms => {:form_type => 'System'});
      end

      if (b_attachable_form_check)
        join_list = [:form];
        attachable_forms = UserForm.joins(join_list)
                                   .where(:user_id => i_user_id)
                                   .where(:procedure_id => i_procedure_id)
                                   .where(:forms => {:form_type => 'Application'});
      end

      if (b_recommendations_form_check)
        join_list = [:recommendation_record];
        recommendation_forms = RecommendationForm.joins(join_list)
                                                 .where(:recommendation_records => {:user_id => i_user_id})
                                                 .where(:recommendation_records => {:procedure_id => i_procedure_id});
      end

      if (b_transcripts_form_check)
        transcripts = Transcript.applicant_transcripts(i_user_id) if current_user.is_staff
        obj["transcripts"] = transcripts;
      end

=begin
      s_forms = []
      system_forms.each do |form|
        form.schema = Form.data_binding(form.schema, form.user_id, session[:user_id])
        s_forms << form
      end
      r_forms = []
      recommendation_forms.each do |form|
        r_forms << RecommendationForm.schema_add_name_relationship(form)
      end
=end


      forms = (system_forms + attachable_forms + recommendation_forms)

      logger.info("forms : #{forms}");

      forms.each do |user_form|
        schema = JSON.parse(user_form.schema)
        arr = []
        maxColumn = 0
        current_row = 0
        blocks = []
        schema.each do |item|
          if current_row != item["row"]
            blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
            maxColumn = 0
            arr = []
            current_row = item["row"]
          end
          maxColumn = item["column"] if item["column"] > maxColumn
          if item["type"] == "file"
            item["files"] = UploadFile.where(:user_form_id => user_form.id)
          end
          arr << OpenStruct.new(item)
        end
        blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
        logger.info "blocks #{blocks.to_json}"
        obj["forms"] << {"form_name" => user_form.form_name, "blocks" => blocks}
      end
      if obj["forms"].present? || obj["transcripts"].present?
        @applicants << obj
      end
    end

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('download_pdfs/pdf_form.html.erb'),
      :footer => {:center => '[page] / [topage]'}
    )

    s_time = Time.now().in_time_zone("Pacific Time (US & Canada)").strftime("%m_%d_%Y_%H%M");
    s_file_name = ("%s_%s_%s.pdf" % [s_round_name, s_interview_name, s_time]);
    send_data(pdf, :filename => s_file_name, :type => "application/pdf");

  end

  def interview_scheduled_applicant_list_pdf
    i_interview_id = params[:interviewId].to_i;
    # i_interview_id = 10860;
    i_mgr_user_id = session[:user_id].to_i;
    mgr_user = User.find_by_id(i_mgr_user_id);

    interview = Interview.find_by_id(i_interview_id);




    @applicant_list = [];
    @s_round_name = '';
    @s_interview_name = '';
    @s_downloader_name = '';

    if (interview && mgr_user)
      i_round_id = interview.round_id;
      @s_interview_name = interview.name;
      round = Round.find_by_id(i_round_id);
      @s_round_name = round.title;
      i_procedure_id = round.procedure_id;
      @s_downloader_name = mgr_user.name;

      interviewers = User.interviewer(i_interview_id);

      total_show_applicants = [];

      interview_position_ids = interview.position_ids();
      total_show_applicants = User.get_position_applicants(i_procedure_id, interview_position_ids) - interviewers;

      GC.start();

      total_show_applicants |= total_show_applicants;

      total_show_applicants = total_show_applicants.sort_by{|e| e[:first_name]};

      GC.start();


      invitees_user_ids = User.joins(:invitees)
                              .where(:invites => {:interview_id => i_interview_id})
                              .pluck(:id);



      b_senior_manager = (is_hiring_mgr(i_procedure_id) || is_admin());
      under_manage_position_ids = Position.get_under_manage_position_ids(i_procedure_id, i_mgr_user_id);

      search_position_ids = b_senior_manager ? interview_position_ids : (interview_position_ids & under_manage_position_ids);

      total_show_applicants.each do |applicant|
        @applicant_list << interview_applicant_list_pdf_struct(applicant, invitees_user_ids, i_interview_id, b_senior_manager, search_position_ids);
      end
    end


    if (false)
      pdf = WickedPdf.new.pdf_from_string(
        render_to_string('download_pdfs/interview_scheduled_applicant_list_pdf.html.erb'),
        :footer => {:center => '[page] / [topage]'}
      )

      s_time = Time.now().in_time_zone("Pacific Time (US & Canada)").strftime("%m_%d_%Y_%H%M");
      s_file_name = ("%s_%s_%s.pdf" % [@s_round_name, @s_interview_name, s_time]);
      send_data(pdf, :filename => s_file_name, :type => "application/pdf");
    else
      @title_row = ["Name", "Position", "selected", "scheduled"]
      s_file_name = ("%s_%s_%s" % [@s_round_name, @s_interview_name, s_time]);


      respond_to do |format|
        format.xlsx {
          response.headers['Content-Disposition'] = "attachment; filename='#{s_file_name}.xlsx'"
        }
      end

    end


  end

  def interview_applicant_list_pdf_struct(user, invitees_user_ids, i_interview_id, b_senior_manager, search_position_ids)
    i_user_id = user.id;

    user_hash = user.as_json();

    user_hash[:name] = user.name;

    user_hash[:positions] = Position.joins(:applications)
                                    .where(:applications => {:user_id => i_user_id})
                                    .where(:positions => {:id => search_position_ids});


    user_hash[:check] = invitees_user_ids.include?(i_user_id) ? 'Y' : 'N';

    user_hash[:time_slots] = TimeSlot.includes(:interviewees).where(:interview_id => i_interview_id, :interviewees => {:user_id => i_user_id});

    return (user_hash);
  end


  def review_pdf
    interviewee = User.find_by_id(params[:interviewee_id]) if params[:interviewee_id]
    procedure = Procedure.find_by_id(params[:current_process_id]) if params[:current_process_id]
    interview = Interview.find_by_id(params[:interview_id]) if params[:interview_id]



    # Parameters: {"interviewee_id"=>10634, "interview_id"=>10537, "current_year_id"=>1, "current_process_id"=>7, "interview_evaluate"=>{"interview_id"=>10537}}

    #interviewee = User.find_by_id(10634)
    #procedure = Procedure.find_by_id(7)
    #interview = Interview.find_by_id(10537)

    @applicants = [];
    @interview_evaluate_forms = [];


    if interviewee && interview && procedure
      forms = Form.where(:procedure_id => procedure.id, :display => true, :form_type => "Interview").order(:rank)

      forms.each do |form|
        interview_evaluates = InterviewEvaluate.includes(:interview_evaluate_form, :reviewer).where(:interview_id => interview.id, :interviewee_user_id => interviewee.id, :form_id => form.id).order(:id);

        if (interview_evaluates)
          logger.info("@ @@@@@@@@@@ interview_evaluates :  #{interview_evaluates.as_json}");

          interview_evaluates.each do |evaluate|
            if evaluate.interview_evaluate_form
              interview_evaluate_form = evaluate.interview_evaluate_form.as_json();
              interview_evaluate_form["reviewer"] = evaluate.reviewer.as_json({
                :methods => :name
              });
              @interview_evaluate_forms << interview_evaluate_form
            end
          end
        end
      end

      s_interviewee_name = interviewee.name;
      s_interview_name = interview.name;

      obj = {};
      obj["interviewee_name"] = s_interviewee_name;
      obj["forms"] = [];

      @interview_evaluate_forms.each do |review_form|
        schema = JSON.parse(review_form["schema"])
        arr = []
        maxColumn = 0
        current_row = 0
        blocks = []
        schema.each do |item|
          if current_row != item["row"]
            blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
            maxColumn = 0
            arr = []
            current_row = item["row"]
          end
          maxColumn = item["column"] if item["column"] > maxColumn
          arr << OpenStruct.new(item)
        end
        blocks << OpenStruct.new({"column" => maxColumn + 1, "items" => arr})
        logger.info "blocks #{blocks.to_json}"
        obj["forms"] << {"form_name" => review_form["form_name"], "blocks" => blocks, "reviewer" => review_form["reviewer"]["name"]}

      end

      if obj["forms"].present?
        @applicants << obj
      end


    end

#=begin
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('download_pdfs/review_pdf.html.erb'),
      :footer => {:center => '[page] / [topage]'}
    )

    s_time = Time.now().in_time_zone("Pacific Time (US & Canada)").strftime("%m_%d_%Y_%H%M");
    s_file_name = ("review_$s_%s_%s_%s.pdf" % [s_interviewee_name, s_interview_name, s_time]);
    send_data(pdf, :filename => s_file_name, :type => "application/pdf");
#=end

  end

end














