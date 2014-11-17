require 'mysql'
require_dependency 'LoginHelper.rb' 


class LoginDao
  def validate(objLogin)
    loginCheck =false;
    # #my = Mysql.new(hostname, username, password, databasename)  
    # con = Mysql.new('127.0.0.1', 'root', 'admin', 'schema1') 
    # query = "select password from login where userName = "+"'" +objLogin.getUserName+"'"  
    # # puts query 
    # rs = con.query(query)  
#     
    # # puts 's'+objLogin.getPassword+'s'
#      
    # # puts 'y'+rs.fetch_row[0]+'y'
    # # puts rs.fetch_row.at(0).eql?(objLogin.getPassword())
#     
    # if rs.fetch_row[0].eql?(objLogin.getPassword())
      # loginCheck =true
    # end
#         
#     
    # rescue Mysql::Error => e
    # puts e.errno
    # puts e.error
    
    
    obj = Login.find_by(:userName => objLogin.getUserName)
    if (obj.password == objLogin.getPassword())
      loginCheck =true
    end
      
    
    puts obj.userName
    puts obj.getPassword
    
    return loginCheck
  end
end


