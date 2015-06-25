class Year < ActiveRecord::Base
  has_paper_trail

  has_many :procedures, :dependent => :destroy
  has_many :users, :dependent => :destroy

  validates_presence_of :name, :message=> "The name is required."
  validates_format_of :name, :with => /^[\d\-]*$/, :multiline => true, :message=> "The name can only contain the number 0-9 and hyphens (-)."
  validates_format_of :next_year, :with => /^[\d\-]*$/, :multiline => true, :message=> "The name can only contain the number 0-9 and hyphens (-)."
  validates_uniqueness_of :name, :message=> "This year already exists."

  def self.get_year_list(table_params)
    order_by_hash = {'Name' => 'years.name', 'Next Year' => 'years.next_year'}
    search_fields = ['years.name', 'years.next_year']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "years.name asc"
    years = Year.where(search_condition)
                .order(order_condition)
                .page(table_params.i_page)
                .per(table_params.i_page_count)
    year_list = years.as_json
    return year_list, years.total_count
  end

  def self.year_list_for_clone
    return Year.select(:id, :name).includes(:procedures).as_json(:include => {:procedures => {:only => [:name]}})
  end

  def self.clone_admins(source_year_id, target_year_id)
    is_success = false

    begin
      User.where(:year_id => source_year_id, :is_admin => true).each do |source_user|
        user_params = source_user.as_json(:only => [:first_name, :middle_name, :last_name, :status, :is_admin, :email, :sunet_id])
        user_params[:year_id] = target_year_id
        target_user = User.create!(user_params)
      end
      is_success = true
    rescue Exception => e
      logger.info "==clone_admins error==#{e.message} : #{e.backtrace}=="
    end

     return is_success
  end
end
