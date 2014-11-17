class ProjectCategory < ActiveRecord::Base
  
  self.table_name = "project_categories"
  
  belongs_to :project
end