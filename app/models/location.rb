class Location < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure
  has_many :limit_manager, :dependent => :destroy
  has_many :positions, :dependent => :destroy
  has_many :location_mgrs, :dependent => :destroy
  has_many :users, :through => :location_mgrs
  has_many :round_tags;

  validates_uniqueness_of :procedure_id, :scope => :name, :message=> "This location already exists."

  after_save :update_position_name

  def update_position_name
    Position.where(:location_id => self.id).each do |position|
      position.name = [position.location.name, position.role.name].join("-")
      position.save
    end

    return true
  end

  def self.get_location_list(table_params, location_ids_condition)
    order_by_hash = {'Name' => 'locations.name', 'Tag' => 'locations.tag', 'Description' => 'locations.description'}
    search_fields = ['locations.name', 'locations.tag', 'locations.description']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "locations.name asc"
    include_condition = [{:location_mgrs => :user}]
    locations = Location.includes(include_condition).references(include_condition)
                        .where(:procedure_id => table_params.i_procedure_id)
                        .where(location_ids_condition)
                        .where(search_condition)
                        .order(order_condition)
                        .page(table_params.i_page)
                        .per(table_params.i_page_count)
    location_list = locations.as_json(:include => [{:location_mgrs => {:include => :user}}])
    return location_list, locations.total_count
  end

  def procedure_name
    return self.procedure ? self.procedure.name : "Error: This process was not found on the server."
  end

  def self.get_locations_with_applicant_tags(procedure_id)
    location_list = []
    include_condition = [:positions => :applications]
    #include_condition = [:positions => [:applications => {:user => {:applicants => :applicant_tags}}]]
    locations = Location.includes(include_condition).references(include_condition).where(:procedure_id => procedure_id).order("lower(locations.name) asc")
    locations.each do |location|
      location_hash = location.as_json()
      location_hash[:tags] = [
        {:name => "Men", :count => 0},
        {:name => "Women", :count => 0},
        {:name => "Transgender", :count => 0}
      ]

      application_user_ids = []
      location.positions.each do |postion|
        postion.applications.each do |application|
          application_user_ids << application.user_id if !application_user_ids.include?(application.user_id)
        end
      end

      Applicant.includes(:applicant_tags).where(:user_id => application_user_ids, :procedure_id => procedure_id).each do |applicant|
        applicant.applicant_tags.each do |applicant_tag|
          if location_hash[:tags].collect{|obj| obj[:name]}.include?(applicant_tag.name)
            tag_hash = location_hash[:tags].detect{|obj| obj[:name] == applicant_tag.name}
            tag_hash[:count] += 1
          else
            location_hash[:tags] << {
              :name => applicant_tag.name,
              :count => 1
            }
          end
        end
      end
      location_hash[:tags].each do |location_tag|
        location_tag[:option_name] = location_tag[:name]
        location_tag[:option_name] += "(#{location_tag[:count]})" if location_tag[:count] != 0
      end
      location_list << location_hash
    end


=begin
      location.positions.each do |postion|
        postion.applications.each do |application|
          application.user.applicants.each do |applicant|
            next if applicant.procedure_id != procedure_id.to_i
            applicant.applicant_tags.each do |applicant_tag|
              if location_hash[:tags].collect{|obj| obj[:name]}.include?(applicant_tag.name)
                tag_hash = location_hash[:tags].detect{|obj| obj[:name] == applicant_tag.name}
                tag_hash[:count] += 1
              else
                location_hash[:tags] << {
                  :name => applicant_tag.name,
                  :count => 1
                }
              end
            end
          end
        end
      end
      location_hash[:tags].each do |location_tag|
        location_tag[:option_name] = location_tag[:name]
        location_tag[:option_name] += "(#{location_tag[:count]})" if location_tag[:count] != 0
      end
      location_list << location_hash
    end
=end
    return location_list
  end
end
