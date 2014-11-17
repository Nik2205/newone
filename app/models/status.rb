class Status < ActiveRecord::Base
  
  self.table_name = "statuses"
  # has_and_belongs_to_many :users
end