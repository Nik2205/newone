    require "mysql"  
    
    class Test
      
      def testing
      #my = Mysql.new(hostname, username, password, databasename)  
      con = Mysql.new('127.0.0.1', 'root', 'admin', 'schema1')  
      rs = con.query('select password from login')  
      # rs.each_hash { |h| puts h['password']}  
      
      puts rs.fetch_row 
      rescue Mysql::Error => e
      puts e.errno
      puts e.error
      
      ensure
          con.close if con
      end
     end 


t = Test.new
t.testing
