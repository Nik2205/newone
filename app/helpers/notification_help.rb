class NotificationHelp
  
   def initialize(currentUser)
      @currentUser = currentUser
   end
   
   def generateNotification(type_of_notification,notify_user_id, affected_id)
      puts "Adding a notification of type"
      objNotification =Notification.new
      objNotification.invoked_by = @currentUser
      objNotification.user_id = notify_user_id
      objNotification.type_of_notification = type_of_notification
      objNotification.affected_id = affected_id
      objNotification.save
   end
   
end