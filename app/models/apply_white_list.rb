class ApplyWhiteList < ActiveRecord::Base
  has_paper_trail

  belongs_to :procedure
  belongs_to :user

  validates_uniqueness_of :procedure_id, :scope => :user_id, :message => "This apply white list already exists."

  def self.user_list(procedure_id)
    return User.joins(:apply_white_lists).select(:id, :sunet_id,:first_name, :middle_name, :last_name).where(:apply_white_lists => {:procedure_id => procedure_id}).as_json(:methods => :name)
  end

  def self.create_user_and_white_list(user_params, year_id, procedure_id)
    msg = ""
    begin
      user = ApplyWhiteList.create_or_find_user(user_params, year_id)

      if ApplyWhiteList.where(:user_id => user.id, :procedure_id => procedure_id).first
        msg = "This apply white list already exists."
      else
        ApplyWhiteList.create!(:user_id => user.id, :procedure_id => procedure_id)
        msg = "success"
      end
    rescue Exception => e
      logger.error "#{e.message} : #{e.backtrace}"
      msg = "There was a problem to create the apply white list."
    end

    return msg
  end

  def self.create_or_find_user(user_params, year_id)
    user = User.where(:sunet_id => user_params[:sunet_id], :year_id => year_id).first
    if user.nil?
      user_params[:year_id] = year_id
      user = User.create!(user_params)
    end

    return user
  end
end
