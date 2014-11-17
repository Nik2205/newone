class FollowUp <  ActiveRecord::Base
  self.table_name = "follow_up"
  belongs_to :user, :foreign_key => :follower_id
end
