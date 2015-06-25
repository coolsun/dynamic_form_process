class UserProcedure < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :procedure

  validates_uniqueness_of :procedure_id, :scope => :user_id, :message=> "This user procedure already exists."

  def procedure_name
    return self.procedure ? self.procedure.name : "Error: This process was not found on the server."
  end
end
