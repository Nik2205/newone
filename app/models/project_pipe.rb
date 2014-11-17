class ProjectPipe < ActiveRecord::Base
  
  self.table_name = "project_pipes"
  
  has_many :projectPipeLikes
  
  has_many :projectPipeComments
   
end