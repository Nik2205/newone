class Suggestion
  
     def initialize(currentUser)
      @currentUser = currentUser
   end
  
    def suggestionsBasedOnInterest
    puts "start suggesting"

    users = User.arel_table
    suggestedfriendsQuery ="";
    
    suggestedUsersByInterest =Array.new
    
    puts "checking for session"
    puts @currentUser

    User.find(@currentUser).userInterests.pluck(:interest_id).each do |userInterest|
      InterestLinking.where(interest_from: userInterest).pluck(:interest_to).each do |linkedInterest|
        UserInterest.where(interest_id: linkedInterest).pluck(:user_id).each do |suggestedUser|

          tempSuggestedUsers = User.where((users[:user_id].eq(suggestedUser).and(users[:city].eq(User.find(@currentUser).city)))).pluck(:user_id)

          if suggestedUsersByInterest == nil
            if ! tempSuggestedUsers.empty?
              if tempSuggestedUsers[0] != @currentUser.to_i
                #suggestedUsersByInterest = Array.new
              suggestedUsersByInterest[0] =tempSuggestedUsers

              end
            end

          else
            if ! tempSuggestedUsers.empty?
              if tempSuggestedUsers[0] != @currentUser.to_i
                if suggestedUsersByInterest.length <3
                  if ! suggestedUsersByInterest.include? tempSuggestedUsers
                    suggestedUsersByInterest << tempSuggestedUsers
                  end
                else
                  break  
                end
              end
            #suggestedUsers << User.where(user_id: suggestedUser).pluck(:user_id)
            end
          end
        end
      end
    end

    if suggestedUsersByInterest == nil or suggestedUsersByInterest.length <3
      User.find(@currentUser).userInterests.pluck(:interest_id).each do |userInterest|
        InterestLinking.where(interest_from: userInterest).pluck(:interest_to).each do |linkedInterest|
          UserInterest.where(interest_id: linkedInterest).pluck(:user_id).each do |suggestedUser|

            tempSuggestedUsers = User.where(users[:user_id].eq(suggestedUser)).pluck(:user_id)

            if suggestedUsersByInterest == nil
              if ! tempSuggestedUsers.empty?
                if tempSuggestedUsers[0] != @currentUser.to_i
                  #suggestedUsersByInterest = Array.new
                suggestedUsersByInterest =tempSuggestedUsers
                end
              end

            else
              if ! tempSuggestedUsers.empty?
                if tempSuggestedUsers[0] != @currentUser.to_i
                  if suggestedUsersByInterest.length <3
                    if ! suggestedUsersByInterest.include? tempSuggestedUsers
                      suggestedUsersByInterest << tempSuggestedUsers
                    end
                  else
                    break  
                  end
                end
              #suggestedUsers << User.where(user_id: suggestedUser).pluck(:user_id)
              end
            end
          end
        end
      end
    end
    
    #puts "suggested users are :"
    #puts suggestedUsersByInterest.inspect
     @suggestedUsersByInterestFinal = Array.new
    suggestedUsersByInterest.each do |suggestedUsersByInterestId|
      if @suggestedUsersByInterestFinal ==nil
        @suggestedUsersByInterestFinal[0] = User.find(suggestedUsersByInterestId)
      else
        @suggestedUsersByInterestFinal << User.find(suggestedUsersByInterestId)
      end 
    end  

    puts "suggested users by interest are :"
    puts @suggestedUsersByInterestFinal.inspect
    return @suggestedUsersByInterestFinal

  end


def suggestionsBasedOnOccupation
    puts "start suggesting "

    users = User.arel_table
    suggestedfriendsQuery ="";

    suggestedUsersByOccupation = Array.new
    
      OccupationLinking.where(occupation_from: User.where(user_id: @currentUser).pluck(:occupation)).pluck(:occupation_to).each do |linkedOcuupation|
          tempSuggestedUsersByOccupation = User.where((users[:occupation].eq(linkedOcuupation).and(users[:city].eq(User.find(@currentUser).city)))).pluck(:user_id)

          if suggestedUsersByOccupation == nil
            if ! tempSuggestedUsersByOccupation.empty?
              if tempSuggestedUsersByOccupation[0] != @currentUser.to_i
                
                #suggestedUsersByOccupation = Array.new
                
                suggestedUsersByOccupation[0] =tempSuggestedUsersByOccupation

              end
            end

          else
            if ! tempSuggestedUsersByOccupation.empty?
              if tempSuggestedUsersByOccupation[0] != @currentUser.to_i
                if suggestedUsersByOccupation.length <=3
                  if ! suggestedUsersByOccupation.include? tempSuggestedUsersByOccupation
                  suggestedUsersByOccupation << tempSuggestedUsersByOccupation
                  end
                else
                  break  
                end
              end
            #@suggestedUsers << User.where(user_id: suggestedUser).pluck(:user_id)
            end
          end
        
      end
    

    if suggestedUsersByOccupation.length <=3 or suggestedUsersByOccupation == nil 
       OccupationLinking.where(occupation_from: User.where(user_id: @currentUser).pluck(:occupation)).pluck(:occupation_to).each do |linkedOcuupation|
          tempSuggestedUsersByOccupation = User.where(users[:occupation].eq(linkedOcuupation)).pluck(:user_id)

          if suggestedUsersByOccupation == nil
            if ! tempSuggestedUsersByOccupation.empty?
              if tempSuggestedUsersByOccupation[0] != @currentUser.to_i
                #suggestedUsersByOccupation = Array.new
              suggestedUsersByOccupation[0] =tempSuggestedUsersByOccupation

              end
            end

          else
            if ! tempSuggestedUsersByOccupation.empty?
              if tempSuggestedUsersByOccupation[0] != @currentUser.to_i
                if suggestedUsersByOccupation.length <=3
                  if ! suggestedUsersByOccupation.include? tempSuggestedUsersByOccupation
                    suggestedUsersByOccupation << tempSuggestedUsersByOccupation
                  end
                else
                  break  
                end
              end
            #@suggestedUsers << User.where(user_id: suggestedUser).pluck(:user_id)
            end
          end
        
      end
    end
    
    
    @suggestedUsersByOccupationFinal = Array.new
    suggestedUsersByOccupation.each do |suggestedUsersByOccupationId|
      if @suggestedUsersByOccupationFinal ==nil
        @suggestedUsersByOccupationFinal[0] = User.find(suggestedUsersByOccupationId)
      else
        @suggestedUsersByOccupationFinal << User.find(suggestedUsersByOccupationId)
      end 
    end  

    puts "suggested users by occupation are :"
    puts @suggestedUsersByOccupationFinal.inspect
    return @suggestedUsersByOccupationFinal
  end

  def pipeSuggestiobyOccupation
    puts "start suggesting Pipes by occupation"
    @pipes =Array.new
     OccupationLinking.where(occupation_from: User.where(user_id: @currentUser).pluck(:occupation)).pluck(:occupation_to).each do |linkedOccupation|
       TagMapping.where(["tag_type = ? and tag_occupation_or_interest = ?", 1, linkedOccupation]).pluck(:tag_id).each do |tagId|
          PipeTags.where(["tag_id = ?",tagId]).pluck(:pipe_id).each do |pipeId|
            pipes = Pipe.where(["pipe_id = ? and pipe_type= ?",pipeId,'N'])
            if ! pipes.empty?
              pipes.each do |pipe|
                if pipe.created_by !=@currentUser
                  if User.find(pipe.created_by).city == User.find(@currentUser).city
                      if @pipes ==nil
                        @pipes[0] = pipe
                      else
                        if @pipes.length <3
                          if ! @pipes.include? pipe
                            @pipes << pipe
                          end  
                        else
                          break
                        end
                      end                    
                  end
                end
              end
              if @pipes ==nil or @pipes.length<3
               pipes.each do |pipe| 
                if pipe.created_by !=@currentUser
                   if User.find(pipe.created_by).city != User.find(@currentUser).city
                     if ! @pipes.include? pipe 
                      @pipes << pipe
                     end
                   end
                   if @pipes.length >=3
                    break
                   end 
                end
               end     
              end
            end
          end    
       end
     end
    return @pipes 
  end  
  
  def pipeSuggestionByInterest
     puts "start suggesting Pipes by interest"
     @pipes =Array.new
     
      User.find(@currentUser).userInterests.pluck(:interest_id).each do |userInterest|
        InterestLinking.where(interest_from: userInterest).pluck(:interest_to).each do |linkedInterest|
          TagMapping.where(["tag_type = ? and tag_occupation_or_interest = ?", 2, linkedInterest]).pluck(:tag_id).each do |tagId|
          PipeTags.where(["tag_id = ?",tagId]).pluck(:pipe_id).each do |pipeId|
            pipes = Pipe.where(["pipe_id = ? and pipe_type= ?",pipeId,'N'])
            if ! pipes.empty?
              pipes.each do |pipe|
                if pipe.created_by !=@currentUser
                  if User.find(pipe.created_by).city == User.find(@currentUser).city
                      if @pipes ==nil
                        @pipes[0] = pipe
                      else
                        if @pipes.length <3
                           if ! @pipes.include? pipe 
                            @pipes << pipe
                           end
                          break
                        end
                      end                    
                  end
                end
              end
              if @pipes ==nil or @pipes.length<3
               pipes.each do |pipe| 
                if pipe.created_by !=@currentUser
                  if User.find(pipe.created_by).city != User.find(@currentUser).city
                     if ! @pipes.include? pipe 
                      @pipes << pipe
                     end 
                  end 
                  if @pipes.length >=3 
                   break
                  end 
                end
               end     
              end
            end
          end    
       end
        end
      end  
     return @pipes
  end
  
  
  
  
  
  def suggestedProjects
    puts "start suggesting projects"
    @suggProjects = Array.new
    UserCategory.where(["user_id = ?",@currentUser]).pluck(:user_category).each do |category|
      ProjectCategory.where("category_id = ?",category).pluck(:project_id).each do |project_id|
        project = Project.find(project_id)
        if User.find(@currentUser) != project.user
          if User.find(@currentUser).city == project.user.city
            if @suggProjects ==nil
                  @suggProjects[0] = project
            else
                if @suggProjects.length <3
                  @suggProjects << project
                else
                  break
                end
            end        
          end
         end 
      end
      puts "testing"
      puts @suggProjects
      
      if @suggProjects ==nil or @suggProjects.length<3
        ProjectCategory.where("category_id = ?",category).pluck(:project_id).each do |project_id|
           project = Project.find(project_id)
          if User.find(@currentUser) != project.user
            if User.find(@currentUser).city != project.user.city
              if @suggProjects ==nil
                      @suggProjects[0] = project
              else
                  
                    if @suggProjects.length <3
                      @suggProjects << project
                    else
                      break
                    end
                  
              end
            end          
          end
         end 
      end
    end
    puts @suggProjects.inspect
    return @suggProjects
  end
  
  
  
  
  
    
    
  def pipeSuggestionsByFollowing
    @pipes =Array.new
    FollowUp.where(["follow_type = ? and follower_id =?" , 1 ,@currentUser]).pluck(:user_or_page_id).each do |followedUser|
      pipes = Pipe.where("created_by = ? and pipe_type= ?",followedUser,'N')
      
      tempSharedPipe =Array.new
      PipeShare.where(["share_by = ? ",followedUser]).each do |sharedPipe|
        if tempSharedPipe ==nil
          tempSharedPipe[0] = sharedPipe
        else
          tempSharedPipe << sharedPipe 
        end
      end
      
      pipes =pipes + tempSharedPipe
      pipes.sort! { |a,b| b.last_updated_date <=> a.last_updated_date }
      
      
      if ! pipes.empty?
        pipes.each do |pipe|
          if @pipes == nil
            @pipes[0] =pipe
          else
            if @pipes.length <3
              @pipes << pipe
            else
              break    
            end
          end 
        end
      end 
    end
    return @pipes
  end 
  
  def pipeSuggestionsByProjectFollowing
    @pipes =Array.new
    FollowUp.where(["follow_type = ? and follower_id =?" , 2 ,@currentUser]).pluck(:user_or_page_id).each do |projectId|
      pipes = ProjectPipe.where("project_id = ?",projectId)
      if ! pipes.empty?
        pipes.each do |pipe|
          if @pipes == nil
            @pipes[0] =pipe
          else
            if @pipes.length <3
              @pipes << pipe
            else
              break    
            end
          end 
        end
      end 
    end
    return @pipes
  end  
  
  

def pipeSuggestionForHelp
    puts "start suggesting Pipes For Help"
    @pipes =Array.new
     #OccupationLinking.where(occupation_from: User.where(user_id: @currentUser).pluck(:occupation)).pluck(:occupation_to).each do |linkedOccupation|
       TagMapping.where(["tag_type = ? and tag_occupation_or_interest = ?", 1, User.where(user_id: @currentUser).pluck(:occupation)]).pluck(:tag_id).each do |tagId|
          PipeTags.where(["tag_id = ?",tagId]).pluck(:pipe_id).each do |pipeId|
            pipes = Pipe.where(["pipe_id = ? and pipe_type= ?",pipeId,'H'])
            if ! pipes.empty?
              pipes.each do |pipe|
                if pipe.created_by !=@currentUser
                  if User.find(pipe.created_by).city == User.find(@currentUser).city
                      if @pipes ==nil
                        @pipes[0] = pipe
                      else
                        if @pipes.length <3
                          @pipes << pipe
                        else
                          break
                        end
                      end                    
                  end
                end
              end
              if @pipes ==nil or @pipes.length<3
               pipes.each do |pipe| 
                if pipe.created_by !=@currentUser
                   if User.find(pipe.created_by).city != User.find(@currentUser).city
                    @pipes << pipe
                   end
                   if @pipes.length >=3
                    break
                   end 
                end
               end     
              end
            end
          end    
       end
     #end
    return @pipes 
  end 
  
  
end  

