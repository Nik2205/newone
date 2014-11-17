class NotificationController < ApplicationController
  
  def checkNotifications
    count = 0
    countOfFollowers = 0
    ccountOfProjectFollowers =0
    notifications = Notification.where(["user_id = ? and read_status = ?",session[:user_id],0])
    if notifications !=nil
      notifications.each do |note|
        if note.type_of_notification ==10
          countOfFollowers = countOfFollowers+1
        elsif note.type_of_notification ==11
          ccountOfProjectFollowers = ccountOfProjectFollowers+1
        else
        count =count+1
        end
      end
      
      if countOfFollowers >0
        count =count+1
      end
      
      if ccountOfProjectFollowers >0
        count =count+1
      end
      
    end
    render html: count
  end
  
  def showNotifications
    objNotification = Notification.where(["user_id = ? and (type_of_notification != ? || type_of_notification != ?)",session[:user_id],10,11])
    
    @notifications =Array.new
    objNotification.each do |note|
      if @notifications == nil
        @notifications[0] =note
      else
        @notifications << note
      end
    end
    
    count = 0
    countOfFollowers = 0
    ccountOfProjectFollowers =0
    @projectFollowerHash = Hash.new
    notifications = Notification.where(["user_id = ? and (type_of_notification = ? || type_of_notification = ?)",session[:user_id],10,11])
    if notifications !=nil
      notifications.each do |note|
        if note.type_of_notification ==10
          countOfFollowers = countOfFollowers+1
        elsif note.type_of_notification ==11
          ccountOfProjectFollowers = ccountOfProjectFollowers+1
          if @projectFollowerHash[note.affected_id] ==nil
            @projectFollowerHash[note.affected_id] = 1
            
          else
            @projectFollowerHash[note.affected_id] =@projectFollowerHash[note.affected_id].to_i + 1
            
          end
          
        else
        count =count+1
        end
      end
      
      if countOfFollowers >0
        count =count+1
      end
      
      if ccountOfProjectFollowers >0
        count =count+1
      end
      
      @countOfFollowers = countOfFollowers
      @ccountOfProjectFollowers = ccountOfProjectFollowers
      puts "Project Follower"
      puts @projectFollowerHash.inspect
      
      
    end
    
    
    #Notification.where(["user_id = ?",session[:user_id]]).destroy_all
 
    render '/show_notifications'
  end
  
  def followerNotification
    puts "show list of Followers"
    notifications = Notification.where(["user_id = ? and type_of_notification = ?",session[:user_id],10])
    @followedUser =Array.new
    notifications.each do |note|
      if @followedUser == nil
        @followedUser[0] = User.find(note.invoked_by)
      else
        @followedUser << User.find(note.invoked_by)
      end
    end
    
     Notification.where(["user_id = ? and read_status = ? ",session[:user_id],0]).each do |note|
        note.read_status =1
        note.save
      end
    
     render '/follower_notification'
  end
  
  def projectFollowerNotification
     puts "show list of Followers of Project"
     
     notifications = Notification.where(["user_id = ? and type_of_notification = ? and affected_id = ?",session[:user_id],11,params[:project_id]])
     @followedProjectUser =Array.new
    notifications.each do |note|
      if @followedProjectUser == nil
        @followedProjectUser[0] = User.find(note.invoked_by)
      else
        @followedProjectUser << User.find(note.invoked_by)
      end
    end
    
     Notification.where(["user_id = ? and read_status = ? ",session[:user_id],0]).each do |note|
        note.read_status =1
        note.save
      end
    
     render '/project_follower_notification'
     
  end
  
end