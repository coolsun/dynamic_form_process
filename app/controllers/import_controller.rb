class ImportController < ApplicationController
  require 'roo'

  def import_mgrs_by_xlsx
    permission_to_show, permission_to_active, permission_message = check_user_permission("import_mgrs_by_xlsx")
    render :json => {:errors => [permission_message]} and return if !permission_to_active

    name =  Time.now.pst_s('%Y-%m-%d_%H%M_') + params['file'].original_filename
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

      sunet_id = input_xlsx.cell(row_number, title_to_column_number["SUNet ID"]).to_s.strip
      first_name = input_xlsx.cell(row_number, title_to_column_number["First Name"]).to_s.strip
      last_name = input_xlsx.cell(row_number, title_to_column_number["Last Name"]).to_s.strip
      status = input_xlsx.cell(row_number, title_to_column_number["Status"]).to_s.strip
      email = input_xlsx.cell(row_number, title_to_column_number["Email"]).to_s.strip
      location_name = input_xlsx.cell(row_number, title_to_column_number["Location"]).to_s.strip
      role_name = input_xlsx.cell(row_number, title_to_column_number["Role"]).to_s.strip

      requires = ["SUNet ID", "First Name", "Last Name", "Status", "Email"]
      checked = true
      requires.each do |require|
        if input_xlsx.cell(row_number, title_to_column_number[require]).blank?
          errors << "Row: #{row_number} #{require} is required."
          checked = false
        end
      end

      next if !checked

      user = User.where(:year_id => params[:current_year_id], :sunet_id => sunet_id).first

      if user
        user.update(
          :first_name => first_name,
          :last_name => last_name,
          :status => status,
          :email => email
        )
      else
        user = User.create(
          :year_id => params[:current_year_id],
          :first_name => first_name,
          :last_name => last_name,
          :status => status,
          :email => email,
          :sunet_id => sunet_id,
        )
      end

      if location_name.present?
        location = Location.where(:procedure_id => params[:current_process_id], :name => location_name).first

        if location
          UserProcedure.create(:procedure_id => params[:current_process_id], :user_id => user.id)
          LocationMgr.create(:location_id => location.id, :user_id => user.id)
        else
          errors << "Row: #{row_number} Location:#{location_name} not found!"
        end
      end

      if role_name.present?
        role = Role.where(:procedure_id => params[:current_process_id], :name => role_name).first

        if role
          UserProcedure.create(:procedure_id => params[:current_process_id], :user_id => user.id)
          RoleMgr.create(:role_id => role.id, :user_id => user.id)
        else
          errors << "Row: #{row_number} Role:#{role_name} not found!"
        end
      end

    end

    File.delete(path)

    render :json => {:errors => errors}
  end

  def import_pre_offered_applicants_by_xlsx
    permission_to_show, permission_to_active, permission_message = check_user_permission("import_pre_offered_applicants_by_xlsx")
    render :json => {:errors => [permission_message]} and return if !permission_to_active

    name =  Time.now.pst_s('%Y-%m-%d_%H%M_') + params['file'].original_filename
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

      sunet_id = input_xlsx.cell(row_number, title_to_column_number["SUNet ID"]).to_s.strip
      position_name = input_xlsx.cell(row_number, title_to_column_number["Position"]).to_s.strip

      requires = ["SUNet ID", "Position"]
      checked = true
      requires.each do |require|
        if input_xlsx.cell(row_number, title_to_column_number[require]).blank?
          errors << "Row: #{row_number} #{require} is required."
          checked = false
        end
      end

      next if !checked

      user = User.where(:year_id => params[:current_year_id], :sunet_id => sunet_id).first

      if !user
        errors << "Row: #{row_number} This user #{sunet_id}  could not be found from the database."
        next
      end

      applicant = Applicant.where(:user_id => user.id, :procedure_id => params[:current_process_id]).first

      if !applicant
        errors << "Row: #{row_number} This applicant #{sunet_id} could not be found from the database."
        next
      elsif applicant.disqualify
        errors << "Row: #{row_number} This applicant #{sunet_id} has been disqualified. He/She is not eligible to receive an offer. "
        next
      elsif !applicant.application_submit_at
        errors << "Row: #{row_number} This applicant #{sunet_id} didn't submit the application. He/She is not eligible to receive an offer."
        next
      elsif applicant.have_offer
        errors << "Row: #{row_number} This applicant #{sunet_id}  has received an order. He/She is not eligible to receive another offer."
        next
      end

      position = Position.where(:name => position_name, :procedure_id => params[:current_process_id]).first

      if !position
        errors << "Row: #{row_number} This position #{position_name} could not be found from the database."
        next
      end

      application = Application.where(:user_id => user.id, :position_id => position.id).first

      if application and ["post_pre_offered", "pre_offered"].include?(application.offered)
        #skip
        next
      end

      if position.selected_vacancy(nil, true) >= position.vacancy
        errors << "Row: #{row_number} No offer is available. The vacancy of this position #{position_name} is full."
        next
      end

      if !application
        application = Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait")
      end

      if params[:identify_name] == "post_offer_offer"
        application.offered = "post_pre_offered"
      else
        application.offered = "pre_offered"
      end

      application.save
    end

    File.delete(path)

    render :json => {:errors => errors}
  end
end
