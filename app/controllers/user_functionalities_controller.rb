#require File.expand_path('C:/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/http_parser.rb-0.5.3-x86-mingw32/lib/http_parser', __FILE__)

#require File.expand_path('C:/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/em-websocket-0.5.0/lib/em-websocket', __FILE__)

class UserFunctionalitiesController < ApplicationController
  def findFriend
    puts "start finding friends"

    @user = User.find(session[:user_id])

    #@pipes =Pipe.all

    # @friends = User.where(phone_no: 9886247733).or(first_name: params[:friendName])

    users = User.arel_table

    if ! params[:friendName].empty?
      friendName = params[:friendName].split(" ")
      if friendName.size ==1
        friendQuery = users[:first_name].eq(params[:friendName])
        friend =  User.where(users[:first_name].eq(params[:friendName]))
        if friend.empty?
          friendQuery = users[:middle_name].eq(params[:friendName]).or(users[:last_name].eq(params[:friendName]))
        end
      elsif friendName.size ==2
        friendQuery = users[:first_name].eq(friendName[0]).and(users[:last_name].eq(friendName[1]))
        friend =  User.where(users[:first_name].eq(friendName[0]).and(users[:last_name].eq(friendName[1])))
        if friend.empty?
          puts "could not find your friend"
          friendQuery = users[:first_name].eq(friendName[0]).or(users[:last_name].eq(friendName[1]))
          friend =  User.where(users[:first_name].eq(friendName[0]).or(users[:last_name].eq(friendName[1])))
          puts friend.inspect
        else
          friendQuery = users[:first_name].eq(friendName[0]).or(users[:first_name].eq(friendName[1]))
          friendQuery = friendQuery.or(users[:middle_name].eq(friendName[0]).or(users[:middle_name].eq(friendName[1])))
          friendQuery = friendQuery.or(users[:last_name].eq(friendName[0]).or(users[:last_name].eq(friendName[1])))
          friend =  User.where(friendQuery)
        end
      elsif friendName.size ==3
        friendQuery = (users[:first_name].eq(friendName[0]).and(users[:middle_name].eq(friendName[1]))).and(users[:last_name].eq(friendName[2]))
        friend =  User.where((users[:first_name].eq(friendName[0]).and(users[:middle_name].eq(friendName[1]))).and(users[:last_name].eq(friendName[2])))
        puts "3 named friend found at first"
        if friend.empty?
          puts "could not find your 3 named friend"
          friendQuery = users[:first_name].eq(friendName[0]).and(users[:middle_name].eq(friendName[1]))
          friend = User.where(friendQuery.or(users[:middle_name].eq(friendName[1]).and(users[:last_name].eq(friendName[2]))))
          if friend.empty?
            friendQuery = users[:first_name].eq(friendName[0]).and(users[:last_name].eq(friendName[2]))
            friend =  User.where(users[:first_name].eq(friendName[0]).and(users[:last_name].eq(friendName[2])))
            if friend.empty?
              friendQuery = users[:first_name].eq(friendName[0]).or(users[:last_name].eq(friendName[2]))
              friend =  User.where(users[:first_name].eq(friendName[0]).or(users[:last_name].eq(friendName[2])))
              if friend.empty?
                friendQuery =  (users[:first_name].eq(friendName[0]).or(users[:first_name].eq(friendName[1]))).or(users[:first_name].eq(friendName[2]))
                friendQuery =  friendQuery.or((users[:middle_name].eq(friendName[0]).or(users[:middle_name].eq(friendName[1]))).or(users[:middle_name].eq(friendName[2])))
                friendQuery =  friendQuery.or((users[:last_name].eq(friendName[0]).or(users[:last_name].eq(friendName[1]))).or(users[:last_name].eq(friendName[2])))

                friend = User.where(friendQuery)
              end
            else
              puts friend.inspect
            end
          end
          puts friend.inspect
        end

      end
    end

    if params[:friendCity] != '-1'
      if friendQuery != nil
        friendQuery = friendQuery.and(users[:city].eq(params[:friendCity]))
      else
        friendQuery = users[:city].eq(params[:friendCity])
      end
    end

    if params[:friendOccupation] != '-1'
      if friendQuery != nil
        friendQuery = friendQuery.and(users[:occupation].eq(params[:friendOccupation]))
      else
        friendQuery = users[:occupation].eq(params[:friendOccupation])
      end
    end
    
     friend = User.where(friendQuery)
    
    puts 'testu'
    @friends =friend
    
    puts friendQuery.inspect
    puts @friends.inspect

   @pipes =Pipe.where(["created_by =? and pipe_type = ?",session[:user_id],'N'])
      @cities = City.all
      @occupations = Occupation.all
      @tags =Tag.all
      
      objSuggestion = Suggestion.new(session[:user_id])
      @suggestedUsersByInterestFinal = objSuggestion.suggestionsBasedOnInterest
      @suggestedUsersByOccupationFinal = objSuggestion.suggestionsBasedOnOccupation
      @suggestedProjects = objSuggestion.suggestedProjects
      
      @yourProjects = Project.where(["created_by = ?",session[:user_id]])
           
      objFollowNetwork = FollowNetwork.new(session[:user_id])
      @listOfFollowers = objFollowNetwork.getListOfFollowers  
      @listOfUserFollowings = objFollowNetwork.getListOfUserFollowings
      @followedProjects = objFollowNetwork.getListOfFollowedProjects
    
      @notification = Array.new
      @user.projects.each do |userProject|
        userProject.projectCollaborators.each do |projectCollaborator|
          if projectCollaborator.active == 'N' or projectCollaborator.active == 'D' 
            if @notification == nil
              @notification[0] =projectCollaborator
            else
              @notification << projectCollaborator   
            end
          end
        end
      end

    puts 'testing'
    puts @friends.inspect

    #puts @friends.inspect
    
    puts "";
    puts "Searching for the project"
    puts "";
    
    
    
    query = "SELECT * FROM projects WHERE INSTR(project_heading, '"+params[:friendName] +"') > 0";
   # projectResults = ActiveRecord::Base.execute(query) 
    projectResults = Project.find_by_sql(query)
    puts projectResults.inspect
    puts "project done"
    

    render "/home"
  #redirect_to "/user"
  end

  def showUser
    puts "showing user"
    puts params[:user_id]
    
    @user = User.find(session[:user_id])
    @searchSuggUser = User.find(params[:user_id])
    @searchSuggUserPipes = Pipe.where(created_by: params[:user_id])
    
    if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],1]).empty?
      @followed =1
    else
      @followed =0  
    end    
    render '/searchSuggestedUser';
    
  end

  def unfollowUser
     @user = User.find(session[:user_id])
     @searchSuggUser = User.find(params[:differentUser])
     @searchSuggUserPipes = Pipe.where(created_by: params[:differentUser])
     
     
     FollowUp.where(["follower_id = ? and follow_type=? and user_or_page_id = ?",session[:user_id],1,params[:differentUser]]).destroy_all
     
     
     if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],1]).empty?
      @followed =1
     else
      @followed =0  
     end    
    render '/searchSuggestedUser';
     
  end
  
  def followUser
     @user = User.find(session[:user_id])
     @searchSuggUser = User.find(params[:differentUser])
     @searchSuggUserPipes = Pipe.where(created_by: params[:differentUser])
     
     objFollowUp = FollowUp.new
     objFollowUp.follow_type = 1
     objFollowUp.user_or_page_id = params[:differentUser]
     objFollowUp.follower_id = session[:user_id]
     objFollowUp.save
     
     if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],1]).empty?
      @followed =1
     else
      @followed =0  
     end    
     
     objNotificationHelp = NotificationHelp.new(session[:user_id])
     objNotificationHelp.generateNotification(10, User.find(params[:differentUser]).user_id ,session[:user_id])
    
     
    render '/searchSuggestedUser';
  end
  
  def sendMessage
    @user = User.find(session[:user_id])
     @searchSuggUser = User.find(params[:differentUser])
     @searchSuggUserPipes = Pipe.where(created_by: params[:differentUser])
     if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],1]).empty?
      @followed =1
     else
      @followed =0  
     end    
     
     objMessage = Message.new
     objMessage.sender_id = session[:user_id]
     objMessage.reciever_id = params[:differentUser]  
     objMessage.message = params[:messageText]
     objMessage.last_updated_date =Date.current
     objMessage.save
     
     
    render '/searchSuggestedUser';
     
  end
  
  


end