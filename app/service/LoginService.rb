require_dependency 'LoginDao.rb' 

class LoginService
 
  def validate(objLogin)
      # puts "At Service"
       @objLoginDao = LoginDao.new 
       return @objLoginDao.validate(objLogin)
  end
end

