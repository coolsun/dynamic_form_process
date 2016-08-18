class StudentFlashcardsController < ApplicationController
  require 'roo'

  def check_permission
    render :json => {
      :is_admin => current_user.is_admin
    };
  end

  def import_student_flashcards_by_xlsx
    permission_to_show, permission_to_active, permission_message = check_user_permission("import_student_flashcards_by_xlsx")
    render :json => {:errors => [permission_message]} and return if !permission_to_active

    year_id = params[:current_year_id]
    name =  'student_flashcards' + Time.now.pst_s('%Y-%m-%d_%H%M_') + params['file'].original_filename
    directory = "public/saas/app/uploads"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(params['file'].read) }

    input_xlsx = Roo::Excelx.new(path)

    title_to_column_number = {}
    errors = []

    input_xlsx.last_column.times do |i|
      column_number = i + 1
      title_to_column_number[input_xlsx.cell(1, column_number)] = column_number
    end

    input_xlsx.last_row.times do |i|
      row_number = i + 1;
      next if row_number == 1;

      suid = input_xlsx.cell(row_number, title_to_column_number["SUID"]).to_s.strip;
      mf = input_xlsx.cell(row_number, title_to_column_number["M/F"]).to_s.strip;
      last_name = input_xlsx.cell(row_number, title_to_column_number["Last Name"]).to_s.strip;
      first_name = input_xlsx.cell(row_number, title_to_column_number["First Name"]).to_s.strip;
      email = input_xlsx.cell(row_number, title_to_column_number["Email"]).to_s.strip;
      location = input_xlsx.cell(row_number, title_to_column_number["Location"]).to_s.strip;
      room_space = input_xlsx.cell(row_number, title_to_column_number["RoomSpace"]).to_s.strip;
      check_in_date = input_xlsx.cell(row_number, title_to_column_number["Check In Date"]).to_s.strip;
      check_out_date = input_xlsx.cell(row_number, title_to_column_number["Check Out Date"]).to_s.strip;
      staff = input_xlsx.cell(row_number, title_to_column_number["Staff"]).to_s.strip;
      new_or_u = input_xlsx.cell(row_number, title_to_column_number["New or U"]).to_s.strip;

      if (suid.present?)
        logger.info("@@ get_student_flashcard_data suid: #{suid}");
        json_message = StudentFlashcard.get_student_flashcard_data(suid, current_user.sunet_id);
        if (json_message.present? &&
            json_message["profile"].present? &&
            json_message["profile"]["demographics"].present? &&
            json_message["profile"]["demographics"]["photoImage"].present?
            )

          sunet_id = json_message["profile"]["demographics"]["sunetId"]
          photo_image = json_message["profile"]["demographics"]["photoImage"]

          check_student_flashcard = StudentFlashcard.where(:suid => suid, :year_id => year_id).first;

          if (check_student_flashcard.present?)
            check_student_flashcard.mf = mf;
            check_student_flashcard.last_name  = last_name;
            check_student_flashcard.first_name = first_name;
            check_student_flashcard.email = email;
            check_student_flashcard.location = location;
            check_student_flashcard.room_space = room_space;
            check_student_flashcard.check_in_date = check_in_date;
            check_student_flashcard.check_out_date = check_out_date;
            check_student_flashcard.staff = staff;
            check_student_flashcard.new_or_u = new_or_u;
            check_student_flashcard.sunet_id = sunet_id;
            check_student_flashcard.image_base64 = photo_image;
            check_student_flashcard.save;
          else
            new_student_flashcard = StudentFlashcard.new;
            new_student_flashcard.year_id = year_id;
            new_student_flashcard.suid = suid;
            new_student_flashcard.mf = mf;
            new_student_flashcard.last_name = last_name;
            new_student_flashcard.first_name = first_name;
            new_student_flashcard.email = email;
            new_student_flashcard.location = location;
            new_student_flashcard.room_space = room_space;
            new_student_flashcard.check_in_date = check_in_date;
            new_student_flashcard.check_out_date = check_out_date;
            new_student_flashcard.staff = staff;
            new_student_flashcard.new_or_u = new_or_u;
            new_student_flashcard.sunet_id = sunet_id;
            new_student_flashcard.image_base64 = photo_image;
            new_student_flashcard.save;
          end
        elsif (json_message[:error_msg].present?)
          errors << "error: suid: #{suid}, #{json_message[:error_msg]}.";
        else
          errors << "unknown error.";
        end

      end

=begin
      requires = []
      checked = true
      requires.each do |require|
        if input_xlsx.cell(row_number, title_to_column_number[require]).blank?
          errors << "Row: #{row_number} #{require} is required."
          checked = false
        end
      end
      next if !checked
=end

    end

    logger.info(errors);

    File.delete(path)
    render :json => {:errors => errors}

  end

  def download_student_flashcards_pdf
    locations = [];

    if current_user.is_admin
      locations = Location.all.pluck(:name);
    else
      hiring_mgr_locations = Location.includes(:procedure => :procedure_mgrs).where(:procedure_mgrs => {:user_id => current_user.id}).pluck(:name);
      location_mgr_locations = Location.includes(:location_mgrs).where(:location_mgrs => {:user_id => current_user.id}).pluck(:name);
      locations = hiring_mgr_locations | location_mgr_locations
    end

    logger.info(locations);

    @student_flashcards = StudentFlashcard.where(:location => locations).order([:location, :last_name]);



#=begin
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('student_flashcards/download_student_flashcards_pdf.html.erb'),
      :footer => {:center => '[page] / [topage]'}
    )

    s_time = Time.now().in_time_zone("Pacific Time (US & Canada)").strftime("%m_%d_%Y_%H%M");
    s_file_name = ("student_flashcards_pdf_%s_%s.pdf" % [current_user.id, s_time]);
    send_data(pdf, :filename => s_file_name, :type => "application/pdf");
#=end
  end


end







