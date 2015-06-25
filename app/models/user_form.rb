class UserForm < ActiveRecord::Base
  has_paper_trail

  belongs_to :user;
  belongs_to :form;
  has_many :upload_files;

end
