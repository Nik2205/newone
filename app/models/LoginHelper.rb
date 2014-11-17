class Login  < ActiveRecord::Base  
   # @userName
   # @password
   # @role
  def getUserName
    @userName
  end

  def getPassword
    @password
  end

  def getRole
    @role
  end

  def setUserName(userName)
    @userName =userName
  end

  def setPassword(password)
    @password = password
  end

  def setRole(role)
    @role = role
  end

end

