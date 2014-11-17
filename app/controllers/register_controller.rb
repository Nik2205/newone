require_dependency 'LoginHelper.rb'
require_dependency 'LoginService.rb'
require_dependency 'user_interest.rb'
class RegisterController < ApplicationController
  # def validate
  # # puts "You were here"
  #
  # @log = Login.new
  #
  # @log.setUserName(params[:user]);
  # @log.setPassword(params[:password])
  #
  # @message = ''
  #
  # @logService = LoginService.new
  # if @logService.validate(@log)
  # puts 'Login Success'
  # @message ='welcome '+  @log.getUserName
  # else
  # @message ='Login unsuccessful ,please check the username or password'
  # end
  #
  # render "success"
  #
  # end
  def showRegistration
    @cities = City.all
    @occupations = Occupation.all
    @interests = Interest.all
    @statuses = Status.all
    @categories = Category.all

    render "/register"
  end

  def register
    if session[:user_id] != ""
      @user = User.find(session[:user_id])
    end
    if session[:user_id] == ""
      @user = User.new(user_params)
    end
    @user.user_type_id = 2;
    @user.created_by = params[:user][:user_name];
    @user.created_date = Date.current;
    @user.last_updated_by = params[:user][:user_name];
    @user.last_updated_date = Date.current;
    # if session[:user_id] != ""
      # @user.user_id = session[:user_id].to_i; 
      # puts @user.user_id
    # end

    @user.phone_no = (params[:user][:phone_no]).to_i;
    
    puts params[:user][:password]
    puts "check"
    puts params[:user][:gender]
    puts params[:user][:user_status]
  
     if session[:user_id] == ""
      valid = @user.save
      UserMailer.welcome_email(@user).deliver
     end
     if session[:user_id] != ""
      valid = @user.update_attributes(user_params)
     end
    

    if valid
      puts "User saved successfully"
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end

    puts "printing interests"
    puts @user.user_id
    if session[:user_id] == ""
      params[:interest_ids].each do |i|
        @userInterest = UserInterest.new
        @userInterest.user_id = @user.user_id
        @userInterest.interest_id = i
        @userInterest.last_updated_date = Date.current;
        @userInterest.save
      end
      
      puts "saving iinto user categories "
      params[:category_ids].each do |i|
        @userCategory = UserCategory.new
        @userCategory.user_id = @user.user_id
        @userCategory.user_category = i
        @userCategory.save
      end
      
      
    end
    if session[:user_id] != ""
      @userInterests = UserInterest.where(user_id: session[:user_id]).pluck(:interest_id)
      
       @userInterests.each do |dbInterest|
           if ! params[:interest_ids].include? dbInterest
             UserInterest.where(:user_id =>session[:user_id] ,:interest_id => dbInterest).destroy_all
             puts "deleted interest"
           end        
       end
       
       params[:interest_ids].each do |i|
        if ! @userInterests.include? i
          @userInterest = UserInterest.new
          @userInterest.user_id = @user.user_id
          @userInterest.interest_id = i
          @userInterest.last_updated_date = Date.current;
          @userInterest.save
          puts 'inserted an user interest'
        end
       end 
       
       
       @userCategory = UserCategory.where(user_id: session[:user_id]).pluck(:user_category)
     
       @userCategory.each do |dbCategory|
           if ! params[:category_ids].include? dbCategory
             UserCategory.where(:user_id =>session[:user_id] ,:user_category => dbCategory).destroy_all
             puts "deleted user category"
           end        
       end
       
       
       params[:category_ids].each do |i|
        if ! @userCategory.include? i
          @userCategory1 = UserCategory.new
          @userCategory1.user_id = @user.user_id
          @userCategory1.user_category = i
          @userCategory1.save
          puts 'inserted an user category'
        end
       end 
       
       
       
       @pipes =Pipe.all
       @cities = City.all
       @occupations = Occupation.all
       @tags = Tag.all
       @categories = Category.all
    end
    

    if session[:user_id] == ""
      render "/home"
    else  
      redirect_to "/user"
    end  
  end

  def updateProfile
    puts session[:user_id]
    @user = User.find(session[:user_id])
    @cities = City.all
    @occupations = Occupation.all
    @interests = Interest.all
    @statuses = Status.all
    @categories = Category.all
    
    @userInterests = UserInterest.where(user_id: session[:user_id]).pluck(:interest_id)
    @userCategories = UserCategory.where(user_id: session[:user_id]).pluck(:user_category)
    puts "check"
    puts @userInterests

    render "/register"
  end

  def user_params
    if session[:user_id] == ""
      params.require(:user).permit(:user_name, :password,:email_id,:user_type_id,:city,:occupation,:first_name,:middle_name,:last_name,:address,
      :created_by,:created_date,:last_updated_by,:last_updated_date,:phone_no,:interest,:category,:user_id,:avatar,:gender,:user_status);
    else
      params.require(:user).permit(:user_name, :email_id,:user_type_id,:city,:occupation,:first_name,:middle_name,:last_name,:address,
      :created_by,:created_date,:last_updated_by,:last_updated_date,:phone_no,:interest,:category,:user_id,:avatar,:gender,:user_status);
    
    end  
  end
end