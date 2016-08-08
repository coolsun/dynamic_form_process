class StudentFlashcardsController < ApplicationController

  require 'roo'

  def import_student_flashcards_by_xlsx
    permission_to_show, permission_to_active, permission_message = check_user_permission("import_student_flashcards_by_xlsx")
    render :json => {:errors => [permission_message]} and return if !permission_to_active


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
      row_number = i + 1
      next if row_number == 1

      suid = input_xlsx.cell(row_number, title_to_column_number["SUID"]).to_s.strip
      mf = input_xlsx.cell(row_number, title_to_column_number["M/F"]).to_s.strip
      last_name = input_xlsx.cell(row_number, title_to_column_number["Last Name"]).to_s.strip
      first_name = input_xlsx.cell(row_number, title_to_column_number["First Name"]).to_s.strip
      email = input_xlsx.cell(row_number, title_to_column_number["Email"]).to_s.strip
      location = input_xlsx.cell(row_number, title_to_column_number["Location"]).to_s.strip
      room_space = input_xlsx.cell(row_number, title_to_column_number["RoomSpace"]).to_s.strip
      check_in_date = input_xlsx.cell(row_number, title_to_column_number["Check In Date"]).to_s.strip
      check_out_date = input_xlsx.cell(row_number, title_to_column_number["Check Out Date"]).to_s.strip
      staff = input_xlsx.cell(row_number, title_to_column_number["Staff"]).to_s.strip
      new_or_u = input_xlsx.cell(row_number, title_to_column_number["New or U"]).to_s.strip

      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      logger.info(suid);
      logger.info(mf);
      logger.info(last_name);
      logger.info(first_name);
      logger.info(email);
      logger.info(location);
      logger.info(room_space);
      logger.info(check_in_date);
      logger.info(check_out_date);
      logger.info(staff);
      logger.info(new_or_u);

      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");





      requires = []
      checked = true
      requires.each do |require|
        if input_xlsx.cell(row_number, title_to_column_number[require]).blank?
          errors << "Row: #{row_number} #{require} is required."
          checked = false
        end
      end

      next if !checked
    end

    File.delete(path)



    render :json => {:errors => errors}
  end
end
