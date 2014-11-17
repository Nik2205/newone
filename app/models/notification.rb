class Notification < ActiveRecord::Base
  
  self.table_name = "notifications"
  
  belongs_to :user, :foreign_key => :invoked_by
 
end