class LoginController < ApplicationController
  def validate

    @user = User.where(user_name: params[:user_name]).take
    salt = '$2a$10$wqvNkNQuSeD2RMjB.6DMxu'
    encrypted_password= BCrypt::Engine.hash_secret(params[:password], salt)

    if (@user.password == encrypted_password)

      session[:user] =  @user.user_name;
      session[:user_id] =  @user.user_id;
      @greeting ="Welcome " +session[:user]
      puts "getting the user id"
      puts session[:user_id]

      @pipes =Pipe.where(["created_by =? and pipe_type= ?",session[:user_id],'N'])
      tempSharedPipe =Array.new
      PipeShare.where(["share_by = ? ",session[:user_id]]).each do |sharedPipe|
        if tempSharedPipe ==nil
          tempSharedPipe[0] = sharedPipe
        else
          tempSharedPipe << sharedPipe 
        end
      end
      
      @pipes =@pipes + tempSharedPipe
      @pipes.sort! { |a,b| b.last_updated_date <=> a.last_updated_date }
      
      
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
      
      
    end

    
    render "/home"

  end

  def logout
    session[:user] =  "";
    session[:user_id] = "";
    # session[:user_id] =  -1;
    render "/home"
  end
  
  def showUser
      @user = User.find(session[:user_id])
      
      @pipes =Pipe.where(["created_by =? and pipe_type = ?",session[:user_id],'N'])
      tempSharedPipe =Array.new
      PipeShare.where(["share_by = ? ",session[:user_id]]).each do |sharedPipe|
        if tempSharedPipe ==nil
          tempSharedPipe[0] = sharedPipe
        else
          tempSharedPipe << sharedPipe 
        end
      end
      
      @pipes =@pipes + tempSharedPipe
      @pipes.sort! { |a,b| b.last_updated_date <=> a.last_updated_date }
      
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
      
    
      
      
      render "/home"
  end
  
  def differentUser
    @user = User.find(session[:user_id])
    @searchSuggUser = User.find(params[:user_id])
    @searchSuggUserPipes = Pipe.where(created_by: params[:user_id])
      render "/searchSuggestedUser"
  end
  
  def pipeSuggest
   @user = User.find(session[:user_id])
      # @pipes =Pipe.all
      # @cities = City.all
      # @occupations = Occupation.all
      # @tags =Tag.all
      
      objSuggestion = Suggestion.new(session[:user_id])
      @pipeSuggestionsByOccupation = objSuggestion.pipeSuggestiobyOccupation
      puts "check pipe suggs by occupation"
      #puts @pipeSuggestionsByOccupation.inspect
      puts "check pipe suggs by interest"
      @pipeSuggestionsByInterest = objSuggestion.pipeSuggestionByInterest
      #puts @pipeSuggestionsByInterest.inspect
      
      puts "check pipe whom you are following"
      @pipeSuggestionsByFollowing = objSuggestion.pipeSuggestionsByFollowing
      #puts @pipeSuggestionsByFollowing.inspect
      
      puts "check pipe from project you are following"
      @pipeSuggestionsByProjectFollowing = objSuggestion.pipeSuggestionsByProjectFollowing
      
      
      
      render "/pipe_suggest"
  end

end