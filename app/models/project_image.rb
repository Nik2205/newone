class ProjectImage < ActiveRecord::Base
  
  self.table_name = "project_images"
  
  has_attached_file :project_image , :path => ':rails_root/app/assets/images/projectRelatedImages/:basename.:extension' ,
  :url =>'projectrelatedImages/:basename.:extension'
  validates_attachment_content_type :project_image, :content_type => /\Aimage\/.*\Z/
 
end