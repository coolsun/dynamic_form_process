class Position < ActiveRecord::Base
  has_paper_trail

  belongs_to :role;
  belongs_to :procedure;
  belongs_to :location;
  has_many :applications, :dependent => :destroy
  has_many :positions_in_interviews;
  has_many :interviews, :through => :positions_in_interviews;

  validates_uniqueness_of :role_id, :scope => :location_id, :message=> "This position already exists."

  before_create :set_position_name

  def selected_vacancy(step = nil, contain_pre_offered = false)
    if contain_pre_offered
      if step == 1
        return Application.where(:position_id => self.id, :offered => ["pre_offered", "offered"]).count
      elsif step == 2
        return Application.where(:position_id => self.id, :offered => ["post_pre_offered", "post_offered"]).count
      else
        return Application.where(:position_id => self.id, :offered => ["post_pre_offered", "post_offered", "offered", "post_offered"]).count
      end
    else
      if step == 1
        return Application.where(:position_id => self.id, :offer_accept => "accepted", :offered => "offered").count
      elsif step == 2
        return Application.where(:position_id => self.id, :offer_accept => "accepted", :offered => "post_offered").count
      else
        return Application.where(:position_id => self.id, :offer_accept => "accepted").count
      end
    end
  end

  def location_mgr_users
    user_ids = self.location.location_mgrs.pluck(:user_id)
    return User.where(:id => user_ids)
  end

  def ranking_user_ids
    submit_and_not_disqualify_user_ids = Applicant.where(:procedure_id => self.procedure_id).select{|o| o.submit_and_not_disqualify}.map{|o| o.user_id}
    select_position_user_ids = self.applications.where(:disable_mgr_rank => nil, :offered => "wait").order(:mgr_rank).pluck(:user_id)

    return select_position_user_ids & submit_and_not_disqualify_user_ids
  end

  def self.get_position_list(table_params, permission_condistion)
    order_by_hash = {'Name' => 'locations.name', 'Tag' => 'positions.tag', 'Vacancy' => 'positions.vacancy', 'Description' => 'positions.description'}
    search_fields = ['roles.name', 'locations.name','positions.tag', 'positions.description']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "locations.name asc"

    include_condition = [:role, :location]
    positions = Position.includes(include_condition).references(include_condition)
                        .where(:procedure_id => table_params.i_procedure_id)
                        .where(permission_condistion[:condistion], permission_condistion[:role_ids], permission_condistion[:location_ids])
                        .where(search_condition)
                        .order(order_condition)
                        .page(table_params.i_page)
                        .per(table_params.i_page_count)
    position_list = positions.as_json(:include => include_condition)
    return position_list, positions.total_count
  end

  def set_position_name
    self.name = [self.location.name, self.role.name].join("-")
  end

  def self.get_offer_list(table_params, filter_options, sub_step)
    order_by_hash = {'Position' => 'locations.name', 'Vacancy' => 'positions.vacancy'}
    search_fields = ['positions.name', 'positions.vacancy']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "positions.name asc"
    filter_where_condition = {}
    if filter_options[:locations].present?
      filter_where_condition[:locations] = {:id => filter_options[:locations]}
    end
    if filter_options[:roles].present?
      filter_where_condition[:roles] = {:id => filter_options[:roles]}
    end

    filter_where_not_condition = {}
    if sub_step != 'offer'
      offered_applications = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => table_params.current_process_id})
      position_ids = offered_applications.pluck(:position_id)
      full_positions = []
      Position.where(:id => position_ids).each do |position|
        if position.vacancy - offered_applications.select{|applicaiotn| applicaiotn.position_id == position.id && applicaiotn.offer_accept == "accepted"}.length <= 0
          full_positions << position.id
        end
      end
      filter_where_not_condition[:id] = full_positions if full_positions.present?
      logger.info "== full_positions #{full_positions} =="
    end

    offer_list = []
    not_submit_and_disqualify_user = (Applicant.where(:procedure_id => table_params.current_process_id, :disqualify => true).pluck(:user_id) +
                                      Applicant.where(:procedure_id => table_params.current_process_id, :application_submit_at => nil).pluck(:user_id)).uniq
    offers = Position.includes([:location, :role])
              .where("positions.vacancy > 0")
              .where(filter_where_condition)
              .where.not(filter_where_not_condition)
              .where(search_condition)
              .order(order_condition)
              .page(table_params.i_page)
              .per(table_params.i_page_count)

    offers.each do |offer|
      applicants = []
      offer.applications.each do |application|
        #logger.info "== #{application.to_json} #{application.user.to_json} =="
        next if not_submit_and_disqualify_user.include?(application.user_id)
        next if sub_step == 'offer' && /post/.match(application.offered)
        next if sub_step != 'offer' && (!(/post|wait|pre_offered/.match(application.offered)) || offered_applications.pluck(:user_id).include?(application.user_id))
        applicants << {
          :application_id => application.id,
          :name => application.user.name,
          :pre_offered => (sub_step == "offer" ? ["pre_offered", "offered"].include?(application.offered) : ["post_pre_offered", "post_offered"].include?(application.offered)),
          :offered => application.offered,
          :auto_match => application.auto_match,
          :offer_accept => application.offer_accept
        }
      end

      offer_list << {
        :id => offer.id,
        :name => offer.name,
        :vacancy => sub_step == 'offer' ? offer.vacancy : offer.vacancy - offer.selected_vacancy(1),
        :applicants => applicants.sort! { |a, b| a[:name].downcase <=> b[:name].downcase }
      }
    end
    return offer_list, offers.total_count
  end

  def self.get_select_position_list(procedure_id, user_id, sub_step)
    select_position_list = []
    if sub_step == 'offer'
      positions = Position.includes(:applications, :role, :location)
                    .where("positions.vacancy > 0")
                    .where(:procedure_id => procedure_id)
    elsif ([sub_step] & ['post_offer_invitations', 'select_position']).count > 0

      offered_applications = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure_id})
      position_ids = offered_applications.pluck(:position_id)
      full_positions = []
      Position.where(:id => position_ids).each do |position|
        if position.vacancy - offered_applications.select{|applicaiotn| applicaiotn.position_id == position.id && applicaiotn.offer_accept == "accepted"}.length <= 0
          full_positions << position.id
        end
      end
      logger.info "== full_positions #{full_positions} =="
      positions = Position.includes(:applications, :role, :location)
                    .where("positions.vacancy > 0")
                    .where("positions.vacancy - (SELECT COUNT(id) FROM applications WHERE offered = 'offered' AND offer_accept = 'accepted' AND position_id = positions.id) > 0")
                    .where(:procedure_id => procedure_id)
                    .where.not(:id => full_positions)

    else

      offered_applications = Application.includes(:position).where(:offered => "offered", :positions => {:procedure_id => procedure_id})
      position_ids = offered_applications.pluck(:position_id)
      full_positions = []
      Position.where(:id => position_ids).each do |position|
        if position.vacancy - offered_applications.select{|applicaiotn| applicaiotn.position_id == position.id && applicaiotn.offer_accept == "accepted"}.length <= 0
          full_positions << position.id
        end
      end
      logger.info "== full_positions #{full_positions} =="
      positions = Position.includes(:applications, :role, :location)
                    .where("positions.vacancy > 0")
                    .where(:procedure_id => procedure_id)
                    .where.not(:id => full_positions)
    end
    positions.each do |position|
      is_select = false
      accept_applications_count = 0
      position.applications.each do |application|
        is_select = true if application.user_id == user_id
        accept_applications_count = accept_applications_count + 1 if application.offer_accept == 'accepted'
      end
      next if accept_applications_count >= position.vacancy && is_select == false
      position = position.as_json(:include => [:role, :location])
      position[:is_select] = is_select
      select_position_list << position
    end
    return select_position_list
  end

  def self.get_post_offer_invitation_list(table_params, filter_options)
    order_by_hash = {'Name' => 'locations.name', 'Vacancy' => 'positions.vacancy'}
    search_fields = ['roles.name', 'locations.name', 'positions.vacancy']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "locations.name asc"
    filter_where_condition = {}
    if filter_options[:locations].present?
      filter_where_condition[:locations] = {:id => filter_options[:locations]}
    end
    if filter_options[:roles].present?
      filter_where_condition[:roles] = {:id => filter_options[:roles]}
    end

    offered_applications = Application.includes(:position).where(:offered => ["offered", "post_offered"], :positions => {:procedure_id => table_params.i_procedure_id})
    position_ids = offered_applications.pluck(:position_id)
    full_positions = []
    Position.where(:id => position_ids).each do |position|
      if position.vacancy - offered_applications.select{|applicaiotn| applicaiotn.position_id == position.id && applicaiotn.offer_accept == "accepted"}.length <= 0
        full_positions << position.id
      end
    end
    filter_where_not_condition = {}
    filter_where_not_condition[:id] = full_positions if full_positions.present?
    logger.info "== full_positions #{full_positions} =="

    offer_list = []
    offers = Position.includes([:location, :role], :applications)
              .where("positions.vacancy > 0")
              .where(filter_where_condition)
              .where.not(filter_where_not_condition)
              .where(search_condition)
              .order(order_condition)
              .page(table_params.i_page)
              .per(table_params.i_page_count)

    applicants = []
    Applicant.includes(:user).where(:procedure_id => table_params.i_procedure_id).where.not(:application_submit_at => nil, :disqualify => true, :user_id => offered_applications.pluck(:user_id)).each do |applicant|
      applicants << {
        :id => applicant.id,
        :name => applicant.user.name,
        :email => applicant.user.email,
        :invited => false
      }
    end
    applicants = applicants.sort! { |a, b| a[:name].downcase <=> b[:name].downcase }
    #logger.info "== can_offered_applicants #{applicants} =="

    offers.each do |offer|
      offer_list << {
        :id => offer.id,
        :name => offer.name,
        :tag => offer.tag,
        :vacancy => offer.vacancy - offer.selected_vacancy(1),
        :applicants => applicants,
        :description => offer.description,
        :auto_matching => offer.auto_matching,
        :one_year_up => offer.one_year_up
      }
    end
    #logger.info "== offers.total_count #{offers.total_count} =="
    return offer_list, offers.total_count
  end


  def self.get_under_manage_position_ids(i_procedure_id, i_mgr_user_id)
    location_positions_ids = Position.joins(:location => :location_mgrs)
                                     .where(:locations => {:procedure_id => i_procedure_id})
                                     .where(:location_mgrs => {:user_id => i_mgr_user_id})
                                     .pluck(:id);

    role_position_ids = Position.joins(:role => :role_mgrs)
                                .where(:positions => {:procedure_id => i_procedure_id})
                                .where(:role_mgrs => {:user_id => i_mgr_user_id})
                                .pluck(:id);

    return (location_positions_ids | role_position_ids);
  end

  def self.get_under_manage_position_ids_only_role(i_procedure_id, i_mgr_user_id)
    role_position_ids = Position.joins(:role => :role_mgrs)
                                .where(:positions => {:procedure_id => i_procedure_id})
                                .where(:role_mgrs => {:user_id => i_mgr_user_id})
                                .pluck(:id);

    return (role_position_ids);
  end

  def attachable_forms
    attachable_forms = []
    Form.where(:procedure_id => self.procedure_id, :form_type => "Application", :display => true).each do |form|
      form_tags = FormTag.where(:form_id => form.id)
      form_match_position_ids = form_tags.select { |form_tag| form_tag.position_id }.collect { |form_tag| form_tag.position_id }
      form_match_location_ids = form_tags.select { |form_tag| form_tag.location_id }.collect { |form_tag| form_tag.location_id }
      form_match_role_ids     = form_tags.select { |form_tag| form_tag.role_id     }.collect { |form_tag| form_tag.role_id }
      if (form_match_position_ids + form_match_location_ids + form_match_role_ids).blank? || form_match_position_ids.include?(self.id) || form_match_location_ids.include?(self.location_id) || form_match_role_ids.include?(self.role_id)
        attachable_forms << form.id
      end
    end
    return attachable_forms
  end

end
