class PipeComment < ActiveRecord::Base
  
  attr_accessor :noOfLikes
  
  self.table_name = "pipe_comments"
  belongs_to :pipe
  has_many :pipeCommentLikes
end