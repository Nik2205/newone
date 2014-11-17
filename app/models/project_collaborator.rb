class ProjectCollaborator < ActiveRecord::Base
  
  self.table_name = "project_collaborators"
  
  belongs_to :user, :foreign_key => :collaborator_id
  
  belongs_to :project
  
end