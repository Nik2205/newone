class ProjectPipeComment < ActiveRecord::Base
  
  attr_accessor :noOfLikes
  
  self.table_name = "project_pipe_comments"
 
  has_many :projectPipeCommentLikes
  
  belongs_to :projectPipe
end