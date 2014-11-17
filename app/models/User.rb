require 'paperclip.rb'
class User < ActiveRecord::Base
  
  has_many :userInterests
  has_many :projects,:foreign_key => :created_by
  
  
  attr_accessor :salt,:encrypted_password,
  # attr_accessible :user_name, :email_id, :password, :password_confirmation
  self.table_name = "users"
  has_attached_file :avatar , :path => ':rails_root/app/assets/images/users/:basename.:extension' ,
  :url =>'users/:basename.:extension'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  
  before_save :encrypt_password
  after_save :clear_password
  def encrypt_password
    puts "password is " 
    if new_record? 
      puts "password is here "+password 
      if password.present?
        # self.salt = BCrypt::Engine.generate_salt
        self.salt = '$2a$10$wqvNkNQuSeD2RMjB.6DMxu'
        puts self.salt
        self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
      self.password = self.encrypted_password
      end
     end 
  end

  def clear_password
    self.password = nil
  end
end