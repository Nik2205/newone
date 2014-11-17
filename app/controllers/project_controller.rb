class ProjectController < ApplicationController
  def createProject
    puts "creating a project"
    
    @genres = ProjectGenre.all
    @types = ProjectType.all
    @categories = Category.all
    
    render '/create_project'
    
  end
  
  
  def addProject
    @project = Project.new(project_params)
    @project.project_status =4
    @project.created_by = session[:user_id]
    @project.created_date = Date.current
    @project.last_updated_date = Date.current
    
    @project.save
    
    if params[:relatedImages] !=nil
      params[:relatedImages].each do |relatedImage|
         objProjectImage = ProjectImage.new
         objProjectImage.project_image = relatedImage
         objProjectImage.project_id = @project.project_id
         objProjectImage.last_updated_date = Date.current
         objProjectImage.user_id = session[:user_id] 
         objProjectImage.save
      end
    end
    #puts "project is "
    #@project.project_status = Status.where(["status_id =?",@project.project_status]).pluck(:status_value)
    
     puts "saving into project categories "
      params[:category_ids].each do |i|
        @projectCategory = ProjectCategory.new
        @projectCategory.project_id = @project.project_id
        @projectCategory.category_id = i
        @projectCategory.save
      end
    
    redirect_to "/show_project/"+@project.project_id.to_s
    
  end
  
  def updateProject
    @project = Project.find(params[:projectId])
    @project.last_updated_date = Date.current
    @project.update_attributes(project_params)
    
    
    if params[:relatedImages] !=nil
      params[:relatedImages].each do |relatedImage|
         objProjectImage = ProjectImage.new
         objProjectImage.project_image = relatedImage
         objProjectImage.project_id = @project.project_id
         objProjectImage.last_updated_date = Date.current
         objProjectImage.user_id = session[:user_id] 
         objProjectImage.save
      end
    end
    
    @projectCategory = ProjectCategory.where(project_id: params[:projectId]).pluck(:category_id)
     
       @projectCategory.each do |dbCategory|
           if ! params[:category_ids].include? dbCategory
             ProjectCategory.where(:project_id =>params[:projectId] ,:category_id => dbCategory).destroy_all
             puts "deleted project category"
           end        
       end
       
       
       params[:category_ids].each do |i|
        if ! @projectCategory.include? i
          @projectCategory1 = ProjectCategory.new
          @projectCategory1.project_id = @project.project_id
          @projectCategory1.category_id = i
          @projectCategory1.save
          puts 'inserted an project category'
        end
       end 
    
    redirect_to "/show_project/"+params[:projectId]
  end
  
  def show_project
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
    
    render '/show_project'
  end
  
  def unfollowProject
     
     FollowUp.where(["follower_id = ? and follow_type=? and user_or_page_id = ?",session[:user_id],2,params[:projectId]]).destroy_all
     
     
     if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],2]).empty?
      @followed =1
     else
      @followed =0  
     end    
     
     puts "value of followed"
     puts @followed
     
    redirect_to "/show_project/"+params[:projectId] 
  end
  
  def followProject
    
    puts "coming here"
     objFollowUp = FollowUp.new
     objFollowUp.follow_type = 2
     objFollowUp.user_or_page_id = params[:projectId]
     objFollowUp.follower_id = session[:user_id]
     objFollowUp.save
     
     if ! FollowUp.where(["follower_id = ? and follow_type=?",session[:user_id],2]).empty?
      @followed =1
     else
      @followed =0  
     end
     
     objNotificationHelp = NotificationHelp.new(session[:user_id])
     objNotificationHelp.generateNotification(11, Project.find(params[:projectId]).created_by ,params[:projectId])
    
         
    redirect_to "/show_project/"+params[:projectId]
  end
  
  def editProject
    @project = Project.find(params[:projectId])
    @genres = ProjectGenre.all
    @types = ProjectType.all
    @categories = Category.all
    @projectCategories = ProjectCategory.where(["project_id = ? ",params[:projectId]]).pluck(:category_id )
    render '/create_project' 
  end
  
  def deleteRelatedImage
    ProjectImage.where(["project_image_id = ?",params[:project_image_id]]).destroy_all
    render text: 'success'
  end
  
  def collabProject
    objProjectCollaborator =ProjectCollaborator.new
    objProjectCollaborator.project_id = params[:projectId]
    objProjectCollaborator.collaborator_id = session[:user_id]
    objProjectCollaborator.active='N'
    objProjectCollaborator.save
    
    objNotificationHelp = NotificationHelp.new(session[:user_id])
    objNotificationHelp.generateNotification(7, Project.find(params[:projectId]).created_by ,params[:projectId])
    
    
    redirect_to "/show_project/"+params[:projectId]  
  end
  
  def deCollabProject
    objProjectCollaborator = ProjectCollaborator.where(["project_id and collaborator_id",params[:projectId],session[:user_id]])
    objProjectCollaborator[0].active = 'D'
    objProjectCollaborator[0].save
    
    objNotificationHelp = NotificationHelp.new(session[:user_id])
    objNotificationHelp.generateNotification(7, Project.find(params[:projectId]).created_by ,params[:projectId])
    
    redirect_to "/show_project/"+params[:projectId]  
  end 
  
  def rejectCollab
      ProjectCollaborator.where(["project_collaborator_id = ?",params[:project_collaborator_id]]).destroy_all
      render text: 'deleted'
      
      objNotificationHelp = NotificationHelp.new(session[:user_id])
      objNotificationHelp.generateNotification(9, ProjectCollaborator.find(params[:project_collaborator_id]).project.created_by ,ProjectCollaborator.find(params[:project_collaborator_id]).project.project_id)
    
  end
  
  def approveCollab
      objProjectCollaborator = ProjectCollaborator.find(params[:project_collaborator_id])
      objProjectCollaborator.active = 'Y'
      objProjectCollaborator.save
      
      objNotificationHelp = NotificationHelp.new(session[:user_id])
      objNotificationHelp.generateNotification(8, ProjectCollaborator.find(params[:project_collaborator_id]).project.created_by ,ProjectCollaborator.find(params[:project_collaborator_id]).project.project_id)
    
      render text: 'approved'
  end
  
  def rejectDeCollab
      objProjectCollaborator = ProjectCollaborator.find(params[:project_collaborator_id])
      objProjectCollaborator.active = 'Y'
      objProjectCollaborator.save
      render text: 'deleted'
  end
  
  def approveDeCollab
      
      ProjectCollaborator.where(["project_collaborator_id = ?",params[:project_collaborator_id]]).destroy_all
      render text: 'approved'
  end
  
   def addPipe
    puts 'Add a Project Pipe'
      
        @pipe = ProjectPipe.new
        
        @pipe.project_id = params[:projectId]
        @pipe.content = params[:pipeContent]
        @pipe.created_by = session[:user_id]
        @pipe.last_updated_by = session[:user_id]
        @pipe.last_updated_date = Date.current;
        
       
              
        if @pipe.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
#         
         # puts "param check"
         # if params[:tag_ids] !=nil
          # params[:tag_ids].each do |tag|
            # pipeTag = PipeTags.new
            # pipeTag.pipe_id = @pipe.pipe_id
            # pipeTag.tag_id = tag
            # pipeTag.save
          # end
         # end 
#        
      
      render json: @pipe
  end
  
   def updatePipe
    puts 'Updating a Project Pipe'
      
        @pipe = ProjectPipe.find(params[:pipe_id])
        
        puts params[:hdn_pipe_content]
        @pipe.content = params[:hdn_pipe_content]
        @pipe.last_updated_by = session[:user_id]
        @pipe.last_updated_date = Date.current;
        
              
        if @pipe.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
       
      #render "/home"
      #redirect_to "/show_project/"+params[:projectId]
      render json: @pipe
  end
  
  def deletePipe
    puts 'Deletting the Pipe'
      
        @pipe = ProjectPipe.find(params[:pipe_id])
        
              
        if @pipe.destroy
          puts "pipe delete successfully"
        else
          puts "pipe couldn't deleted"
        end
       
      #render "/home"
      #redirect_to "/show_project/"+params[:projectId]
      render json: @pipe
      
  end
  
  def likePipe
    if ProjectPipeLike.where(["user_id =? and project_pipe_id =?",session[:user_id],params[:pipeId]]).empty?
      objProjectPipeLike = ProjectPipeLike.new
      objProjectPipeLike.project_pipe_id = params[:pipeId]
      objProjectPipeLike.user_id = session[:user_id]
      objProjectPipeLike.last_updated_date = Date.current
      objProjectPipeLike.save
    end
    
    objNotificationHelp = NotificationHelp.new(session[:user_id])
    objNotificationHelp.generateNotification(4, ProjectPipe.find(params[:pipeId]).created_by ,params[:pipeId])
        
    #render '/test'
    render html: ProjectPipeLike.where(["project_pipe_id =?",params[:pipeId]]).count
  end
  
  def unLikePipe
    ProjectPipeLike.where(["user_id =? and project_pipe_id =?",session[:user_id],params[:pipeId]]).destroy_all
    
    #render '/test'
    render html: ProjectPipeLike.where(["project_pipe_id =?",params[:pipeId]]).count
  end
  
  def addComment
    
        @pipeComment = ProjectPipeComment.new
        
        
        @pipeComment.project_pipe_id= params[:pipe_id]
        @pipeComment.user_id = session[:user_id]
        @pipeComment.comment = params[:pipe_comment]
        @pipeComment.last_updated_date = Date.current;
              
        if @pipeComment.save
          puts "pipe Comment saved successfully"
        else
          puts "pipe comment couldn't saved"
        end
        
       @pipeComment.noOfLikes = @pipeComment.projectPipeCommentLikes.count
       
      objNotificationHelp = NotificationHelp.new(session[:user_id])
      objNotificationHelp.generateNotification(5, ProjectPipe.find(params[:pipe_id]).created_by ,params[:pipe_id])
       
      
      #render "/home"
      #redirect_to "/show_project/"+params[:projectId]
      render json: @pipeComment.to_json(:methods => :noOfLikes)
  end
  
   def updateComment
    puts 'Updating a Comment'
      
        @pipeComment = ProjectPipeComment.find(params[:pipe_comment_id])
        
        @pipeComment.comment = params[:pipe_comment]
        @pipeComment.user_id = session[:user_id]
        @pipeComment.last_updated_date = Date.current;
        
              
        if @pipeComment.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
       
      #render "/home"
      #redirect_to "/show_project/"+params[:projectId]
      render json: @pipeComment
  end
  
  def deleteComment
    puts 'deleting a Comment'
      
        @pipeComment = ProjectPipeComment.find(params[:pipe_comment_id])
        
              
        if @pipeComment.destroy
          puts "pipeComment delete successfully"
        else
          puts "pipe couldn't deleted"
        end
       
      #render "/home"
      #redirect_to "/show_project/"+params[:projectId]
      render json: @pipeComment
  end
  
  def likePipeComment
    if ProjectPipeCommentLike.where(["user_id =? and project_pipe_comment_id =?",session[:user_id],params[:pipeCommentId]]).empty?
      objProjectPipeCommentLike = ProjectPipeCommentLike.new
      objProjectPipeCommentLike.project_pipe_comment_id = params[:pipeCommentId]
      objProjectPipeCommentLike.user_id = session[:user_id]
      objProjectPipeCommentLike.last_updated_date = Date.current
      objProjectPipeCommentLike.save
    end
    
    objNotificationHelp = NotificationHelp.new(session[:user_id])
    objNotificationHelp.generateNotification(6, ProjectPipeComment.find(params[:pipeCommentId]).user_id ,ProjectPipeComment.find(params[:pipeCommentId]).projectPipe.project_pipe_id)
    
    
    render html: ProjectPipeCommentLike.where(["project_pipe_comment_id =?",params[:pipeCommentId]]).count
  end
 
  def unLikePipeComment
    ProjectPipeCommentLike.where(["user_id =? and project_pipe_comment_id =?",session[:user_id],params[:pipeCommentId]]).destroy_all
    
    render html: ProjectPipeCommentLike.where(["project_pipe_comment_id =?",params[:pipeCommentId]]).count
  end    
  
  def project_params
    
      params.require(:project).permit(:project_heading, :project_description,:project_genre,:project_type,:project_image);
    
  end
end