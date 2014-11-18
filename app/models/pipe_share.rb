class PipeShare < ActiveRecord::Base
  
  self.table_name = "pipe_shares"
  belongs_to :pipe
  belongs_to :user, :foreign_key => :share_from
end