class Project < ActiveRecord::Base
  
  self.table_name = "projects"
  
  has_attached_file :project_image , :path => ':rails_root/app/assets/images/projectImages/:basename.:extension' ,
  :url =>'projectImages/:basename.:extension'
  validates_attachment_content_type :project_image, :content_type => /\Aimage\/.*\Z/

  has_many :projectImages
  has_many :projectCollaborators
  has_many :projectPipes
  
  belongs_to :user , :foreign_key => :created_by
  
end