class FollowNetwork
  
   def initialize(currentUser)
      @currentUser = currentUser
      @follows = FollowUp.arel_table
   end
  
  def getListOfFollowers
      @listOfFollowers = Array.new
      FollowUp.where(@follows[:user_or_page_id].eq(@currentUser).and(@follows[:follow_type].eq(1))).pluck(:follower_id).each do |follower|
        if @listOfFollowers ==nil
          @listOfFollowers[0] = User.find(follower)
        else
          if @listOfFollowers.length <3
          @listOfFollowers << User.find(follower)
          end
        end
      end
      return @listOfFollowers
   end   
      
   def getListOfUserFollowings   
      @listOfUserFollowings = Array.new
      
      FollowUp.where(@follows[:follower_id].eq(@currentUser).and(@follows[:follow_type].eq(1))).pluck(:user_or_page_id).each do |following|
        if @listOfUserFollowings ==nil
          @listOfUserFollowings[0] = User.find(following)
        else
          if @listOfUserFollowings.length <3
          @listOfUserFollowings << User.find(following)
          end
        end
      end
      return  @listOfUserFollowings
   end   
   
   def getListOfFollowedProjects
    @followedProjects = Array.new
      FollowUp.where(["follow_type = ? and follower_id = ?",2,@currentUser]).pluck(:user_or_page_id).each do |projectId|
        if @followedProjects == nil
          @followedProjects[0] = Project.find(projectId)
        else
          @followedProjects << Project.find(projectId)  
        end
      end
      return @followedProjects
   end
   
end