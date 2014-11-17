class GeneralUtilitiesController < ApplicationController
  def showPipe
    @user =User.find(session[:user_id])
    @pipes = Pipe.where("pipe_id = ? ",params[:pipe_id])
    
      Notification.where(["user_id = ? and read_status = ? ",session[:user_id],0]).each do |note|
        note.read_status =1
        note.save
      end
    
    render '/show_pipe'
  end
   
  def showProjectPipe
    @user =User.find(session[:user_id])
    @pipes = ProjectPipe.where("project_pipe_id = ? ",params[:pipe_id])
    Notification.where(["user_id = ? and read_status = ? ",session[:user_id],0]).each do |note|
        note.read_status =1
        note.save
    end
    render '/show_project_pipe'
  end 
  
  def show_project_notification
     @project = Project.find(params[:project_id])
    @projectStatus= Status.where(["status_id =?",@project.project_status]).pluck(:status_value)
    @projectGenre= ProjectGenre.where(["project_genre_id =?",@project.project_genre]).pluck(:project_genre_name)
    @projectType= ProjectType.where(["project_type_id =?",@project.project_type]).pluck(:project_type_name)
    
    if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],2]).empty?
      @followed =1
    else
      @followed =0  
    end
    
    projectCollaborator =ProjectCollaborator.where(["collaborator_id = ? and project_id=?",session[:user_id],params[:project_id]]) 
    if ! projectCollaborator.empty?
      if projectCollaborator[0].active == 'Y'
          @colab =1
      elsif projectCollaborator[0].active == 'N'
          @colab =2
      else
          @colab =3  
      end 
    else
      @colab =4
    end
    
    #@tags = Tag.all
    @allowedToAdd = 0
    
    if ! ProjectCollaborator.where(["project_id =? and collaborator_id =? and active =?",params[:project_id] , session[:user_id], 'Y']).empty?
      @allowedToAdd = 1
    else
        if @project.created_by ==  session[:user_id]
          @allowedToAdd = 1
        end
    end
    
    @pipes =ProjectPipe.where(["project_id = ?",params[:project_id]])
    @user = User.find(session[:user_id])
    
    @listOfCollaborators = ProjectCollaborator.where(["project_id = ?",params[:project_id]])
    @listOfFollowers = FollowUp.where(["follow_type = ? and user_or_page_id = ?" , 2 , params[:project_id]])
    
    Notification.where(["user_id = ? and read_status = ? ",session[:user_id],0]).each do |note|
        note.read_status =1
        note.save
    end
    
    render '/show_project'
  end  
end