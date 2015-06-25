class Role < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure;
  has_many :limit_managers, :dependent => :destroy
  has_many :positions, :dependent => :destroy
  has_many :role_mgrs, :dependent => :destroy
  has_many :users, :through => :role_mgrs
  has_many :round_tags;

  validates_uniqueness_of :procedure_id, :scope => :name, :message=> "This role already exists."

  after_save :update_position_name

  def update_position_name
    Position.where(:role_id => self.id).each do |position|
      position.name = [position.location.name, position.role.name].join("-")
      position.save
    end

    return true
  end

  def self.get_role_list(table_params, role_ids_condition)
    order_by_hash = {'Name' => 'roles.name', 'Tag' => 'roles.tag', 'Description' => 'roles.description'}
    search_fields = ['roles.name', 'roles.tag', 'roles.description']
    search_condition = RsasTools.get_where_search_condition(search_fields, table_params.us_search_text)
    order_condition = table_params.us_order_by.present? ? "#{order_by_hash[table_params.us_order_by]} #{table_params.s_asc_or_desc}" : "roles.name asc"
    include_condition = [{:role_mgrs => :user}]
    roles = Role.includes(include_condition).references(include_condition)
                .where(:procedure_id => table_params.i_procedure_id)
                .where(role_ids_condition)
                .where(search_condition)
                .order(order_condition)
                .page(table_params.i_page)
                .per(table_params.i_page_count)
    role_list = roles.as_json(:include => [{:role_mgrs => {:include => :user}}])
    return role_list, roles.total_count
  end

  def procedure_name
    return self.procedure ? self.procedure.name : "Error: This process was not found on the server."
  end
end
