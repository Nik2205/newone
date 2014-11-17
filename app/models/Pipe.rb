class Pipe < ActiveRecord::Base
  
  self.table_name = "pipes"
  
  has_many :pipeComments
  
  has_many :pipeLikes
 
  
  belongs_to :user, :foreign_key => :created_by
  
end