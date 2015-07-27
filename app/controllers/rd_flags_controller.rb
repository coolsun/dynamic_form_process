class RdFlagsController < ApplicationController

  def index
    permission_to_show, permission_to_active, permission_message = check_user_permission("rd_flag")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    #applicants = Applicant.includes(:user).references(:user).where(:procedure_id => params[:current_process_id])
    applicants = Applicant.includes(:user => :rd_records).references(:user => :rd_records)
                          .where(:procedure_id => params[:current_process_id])
                          .where.not(:rd_records => {:id => nil})
                          .order("last_name asc")

    applicant_list = applicants.as_json({
      :include => {
        :user => {
          :include => {
            :rd_records => {
              :except => [:created_at, :updated_at, :id, :user_id]
            }
          },
          :methods => [:name],
          :only => [:name, :suid]
        }
      }
    })

    applicant_list = applicant_list.select { |applicant| applicant["user"]["name"].include? params[:keyword] } if params[:keyword].present?

    page = params[:page] ? params[:page].to_i : 1 # If there is no params[:page] return 1
    applicant_per_page = 25 # Set the applicant number per page

    page_num_list = *(1..(applicant_list.count.to_f / applicant_per_page.to_f).ceil) # Produce an array to create button list later
    page = 1 if page < 1
    page = (applicant_list.count.to_f / applicant_per_page.to_f).ceil if page > (applicant_list.count.to_f / applicant_per_page.to_f).ceil

    first_applicant_index = (page - 1) * applicant_per_page # Get the first applicant index in current page

    if STANFORD68 || (Rails.env == "production")
      current_host_url = "https://" + request.host + "/saas/app/index.html#"
    else
      current_host_url = "http://" + request.host_with_port + "/saas/app/index.html#"
    end

    render :json => {
      :success => true,
      :applicant_list => applicant_list[0 + first_applicant_index, applicant_per_page],
      :page_num_list => page_num_list,
      :current_page => page,
      :current_host_url => current_host_url,
      :stanford68 => STANFORD68
    }
  end

  def update
    permission_to_show, permission_to_active, permission_message = check_user_permission("rd_flag")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    this_applicant = Applicant.find_by_id(params[:id])
    this_applicant.rd_flag_color = params[:rd_flag_color]
    this_applicant.save!

    render :json => {:success => true, :rd_flag_color => this_applicant.rd_flag_color}
  end

  def get_involved_student
    permission_to_show, permission_to_active, permission_message = check_user_permission("rd_flag")
    render :json => {:success => false, :msg => permission_message} and return if !permission_to_show

    involved_user_id = User.where(:suid => params[:involved_suid]).pluck(:id).first
    if involved_user_id.nil?
      render :json => {:success => false, :msg => "The student is not an applicant."}
    else
      involved_applicant = Applicant.where(:user_id => involved_user_id, :procedure_id => params[:current_process_id]).as_json({:include => {:user => {:methods => [:name], :only => [:name, :suid]}}}).first
      if !involved_applicant.nil?
        render :json => {:success => true, :ill_rec => get_illegal_record(params[:involved_suid]), :applicant => involved_applicant}
      else
        render :json => {:success => false, :msg => "This student does not apply this process."}
      end
    end
  end

  def get_illegal_record(suid)
    ssl_client_cert = nil;
    ssl_client_key = nil;

    f_crt = File.read(SSL_CRT_PATH)
    f_key = File.read(SSL_KEY_PATH)

    if Rails.env == "production"
      api_url = "https://saisapp96.stanford.edu/saservice2/v2.0/cases/queries.json?c=zdGrfTPcKJCHdWDreXKq663zkYGaMo&requesterId=#{current_user.sunet_id}"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key, SSL_KEY_PASSWORD);
    else
      api_url = "https://saisappdev96.stanford.edu/saservice2/v2.0/cases/queries.json?c=22222-111&requesterId=bsun2"

      ssl_client_cert = OpenSSL::X509::Certificate.new(f_crt);
      ssl_client_key = OpenSSL::PKey::RSA.new(f_key);
    end

    client = RestClient::Resource.new(
      api_url,
      :ssl_client_cert  =>  ssl_client_cert,
      :ssl_client_key   =>  ssl_client_key,
      :verify_ssl       =>  false
    );
    single_applicant_ill_recs = client.post({:studentId => suid})

    return JSON.parse(single_applicant_ill_recs)
  end

end
