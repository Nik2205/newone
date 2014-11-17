
class PipeController < ApplicationController
    respond_to :html, :js

  def addPipe
    puts 'Add a Pipe'
      
        @pipe = Pipe.new
        
        
        @pipe.content = params[:pipeContent]
        @pipe.created_by = session[:user_id]
        @pipe.updated_by = session[:user_id]
        @pipe.created_date = Date.current;
        @pipe.last_updated_date = Date.current;
        
       if params[:help] != nil
         if params[:help] == "help"
           @pipe.pipe_type='H'
         end
       end
              
        if @pipe.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
        
         puts "param check"
         puts params[:tag_ids]
         if params[:tag_ids] !=nil
          params[:tag_ids].each do |tag|
            pipeTag = PipeTags.new
            pipeTag.pipe_id = @pipe.pipe_id
            pipeTag.tag_id = tag
            pipeTag.save
          end
         end 
       
      #render "/home"
      #redirect_to "/user"
      render json: @pipe
  end
  
  
  def updatePipe
    puts 'Updating a Pipe'
      
        @pipe = Pipe.find(params[:pipe_id])
        
        puts params[:hdn_pipe_content]
        @pipe.content = params[:hdn_pipe_content]
        @pipe.updated_by = session[:user_id]
        @pipe.last_updated_date = Date.current;
        
              
        if @pipe.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
       
      #render "/home"
      #redirect_to "/user"
      render json: @pipe
  end
  
  def deletePipe
    puts 'Updating a Pipe'
      
        @pipe = Pipe.find(params[:pipe_id])
        
              
        if @pipe.destroy
          puts "pipe delete successfully"
        else
          puts "pipe couldn't deleted"
        end
       
      #render "/home"
      #redirect_to "/user"
      render json: @pipe
  end
  
  
  
  def addComment
    
        @pipeComment = PipeComment.new
        
        
        @pipeComment.pipe_id= params[:pipe_id]
        @pipeComment.user_id = session[:user_id]
        @pipeComment.comment = params[:pipe_comment]
        @pipeComment.last_updated_date = Date.current;
              
        if @pipeComment.save
          puts "pipe Comment saved successfully"
        else
          puts "pipe comment couldn't saved"
        end
        
        @pipeComment.noOfLikes = @pipeComment.pipeCommentLikes.count
       
        objNotificationHelp = NotificationHelp.new(session[:user_id])
        objNotificationHelp.generateNotification(2, PipeComment.find(@pipeComment.pipe_comment_id).pipe.user.user_id ,params[:pipe_id])
       
        #@pipeComment[:noOfLikes] =@pipeComment.pipeCommentLikes.count 
      #render "/home"
      #redirect_to "/user"
      render json: @pipeComment.to_json(:methods => :noOfLikes)
  end
  
  def updateComment
    puts 'Updating a Comment'
      
        @pipeComment = PipeComment.find(params[:pipe_comment_id])
        
        @pipeComment.comment = params[:pipe_comment]
        @pipeComment.user_id = session[:user_id]
        @pipeComment.last_updated_date = Date.current;
        
              
        if @pipeComment.save
          puts "pipe saved successfully"
        else
          puts "pipe couldn't saved"
        end
       
      #render "/home"
      #redirect_to "/user"
      render json: @pipeComment
  end
  
  def deleteComment
    puts 'deleting a Comment'
      
        @pipeComment = PipeComment.find(params[:pipe_comment_id])
        
              
        if @pipeComment.destroy
          puts "pipeComment delete successfully"
        else
          puts "pipe couldn't deleted"
        end
       
      #render "/home"
      #redirect_to "/user"
      render json: @pipeComment
  end

  def addCommentOnDifferentUser
    
        @pipeComment = PipeComment.new
        
        
        @pipeComment.pipe_id= params[:pipe_id]
        @pipeComment.user_id = session[:user_id]
        @pipeComment.comment = params[:pipe_comment]
        @pipeComment.last_updated_date = Date.current;
              
        if @pipeComment.save
          puts "pipe Comment saved successfully"
        else
          puts "pipe comment couldn't saved"
        end
        
        objNotificationHelp = NotificationHelp.new(session[:user_id])
        objNotificationHelp.generateNotification(2, PipeComment.find(@pipeComment.pipe_comment_id).pipe.user.user_id ,params[:pipe_id])
       
      
      #render "/home"
      redirect_to "/differentUser/"+params[:differentUser]
  end
  
  def deleteCommentOnDifferentUser
    puts 'deleting a Comment'
      
        @pipeComment = PipeComment.find(params[:pipe_comment_id])
        
              
        if @pipeComment.destroy
          puts "pipeComment delete successfully"
        else
          puts "pipe couldn't deleted"
        end
       
      #render "/home"
      redirect_to "/differentUser/"+params[:differentUser]
  end

  def likePipe
    if PipeLike.where(["user_id =? and pipe_id =?",session[:user_id],params[:pipeId]]).empty?
      objPipeLike = PipeLike.new
      objPipeLike.pipe_id = params[:pipeId]
      objPipeLike.user_id = session[:user_id]
      objPipeLike.last_updated_date = Date.current
      objPipeLike.save
      
      
      objNotificationHelp = NotificationHelp.new(session[:user_id])
      objNotificationHelp.generateNotification(1, Pipe.find(params[:pipeId]).created_by ,params[:pipeId])
      
    end
    
    #render '/test'
    render html: PipeLike.where(["pipe_id =?",params[:pipeId]]).count
  end
  
  def unLikePipe
    PipeLike.where(["user_id =? and pipe_id =?",session[:user_id],params[:pipeId]]).destroy_all
    
    #render '/test'
    render html: PipeLike.where(["pipe_id =?",params[:pipeId]]).count
  end  
     
  def likePipeComment
    if PipeCommentLike.where(["user_id =? and pipe_comment_id =?",session[:user_id],params[:pipeCommentId]]).empty?
      objPipeCommentLike = PipeCommentLike.new
      objPipeCommentLike.pipe_comment_id = params[:pipeCommentId]
      objPipeCommentLike.user_id = session[:user_id]
      objPipeCommentLike.last_updated_date = Date.current
      objPipeCommentLike.save
    end
    
    objNotificationHelp = NotificationHelp.new(session[:user_id])
    objNotificationHelp.generateNotification(3, PipeComment.find(params[:pipeCommentId]).user_id ,PipeComment.find(params[:pipeCommentId]).pipe.pipe_id)
    
    render html: PipeCommentLike.where(["pipe_comment_id =?",params[:pipeCommentId]]).count
  end    
      
  
  def unLikePipeComment
    PipeCommentLike.where(["user_id =? and pipe_comment_id =?",session[:user_id],params[:pipeCommentId]]).destroy_all
    
    render html: PipeCommentLike.where(["pipe_comment_id =?",params[:pipeCommentId]]).count
  end      
end
