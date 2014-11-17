Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
   get '/hello', to: 'pages#home'
   
   get '/registeration', to: 'register#showRegistration'
   
   post '/register', to: 'register#register'
   
   post '/login', to: 'login#validate'
   
   get '/user', to: 'login#showUser'
   
   get '/differentUser/:user_id', to: 'login#differentUser'
   
   get '/updateProfile', to: 'register#updateProfile'
   
   get '/logout', to: 'login#logout'
   
   post '/findFriend' , to: 'user_functionalities#findFriend'
   
   post '/addPipe' ,to: 'pipe#addPipe'
   
   post '/updatePipe' , to: 'pipe#updatePipe' 
   
   post '/deletePipe' , to: 'pipe#deletePipe'
   
   post '/addComment' ,to: 'pipe#addComment' 
   
   post '/updateComment' ,to: 'pipe#updateComment'
   
   post '/deleteComment' , to: 'pipe#deleteComment'
   
   post 'showUser/:user_id', to: 'user_functionalities#showUser'
  
   post '/addCommentOnDifferentUser' ,to: 'pipe#addCommentOnDifferentUser' 
   
   post '/deleteCommentOnDifferentUser' ,to: 'pipe#deleteCommentOnDifferentUser' 
   
   post '/pipesuggestor' , to: 'login#pipeSuggest'
   
   post '/unfollowUser' ,to: 'user_functionalities#unfollowUser'
   
   post '/followUser' ,to: 'user_functionalities#followUser'
   
   post '/sendMessage' ,to: 'user_functionalities#sendMessage'
   
   post '/likePipe' ,to: 'pipe#likePipe'
   
   post '/unLikePipe' ,to: 'pipe#unLikePipe'
   
   
   post '/likePipeComment' ,to: 'pipe#likePipeComment'
   
   post '/unLikePipeComment' ,to: 'pipe#unLikePipeComment'
   
   post '/createProject' ,to: 'project#createProject'
   
   post '/addProject' ,to: 'project#addProject'
   
   post 'show_project/:project_id', to: 'project#show_project'
   
   post '/unfollowProject' ,to: 'project#unfollowProject'
   
   post '/followProject' ,to: 'project#followProject'
   
   post '/editProject' ,to: 'project#editProject'
   
   post '/updateProject' ,to: 'project#updateProject'
   
   post '/deleteRelatedImage' ,to: 'project#deleteRelatedImage'
   
   post '/collabProject' ,to: 'project#collabProject'
   
   post '/deCollabProject' ,to: 'project#deCollabProject'
   
   post '/rejectCollab' ,to: 'project#rejectCollab'
   
   post '/approveCollab' ,to: 'project#approveCollab'
   
   post '/rejectDeCollab' ,to: 'project#rejectDeCollab'
   
   post '/approveDeCollab' ,to: 'project#approveDeCollab'
   
   post '/addProjectPipe' ,to: 'project#addPipe'
   
   post '/updateProjectPipe' , to: 'project#updatePipe'
   
   post '/deleteProjectPipe' , to: 'project#deletePipe'
   
   post '/likeProjectPipe' ,to: 'project#likePipe'
   
   post '/unLikeProjectPipe' ,to: 'project#unLikePipe'   
   
   post '/addProjectPipeComment' ,to: 'project#addComment'
   
   post '/updateProjectPipeComment' ,to: 'project#updateComment'    
       
   post '/deleteProjectPipeComment' , to: 'project#deleteComment'
   
   post '/likeProjectPipeComment' ,to: 'project#likePipeComment'    
           
   post '/unLikeProjectPipeComment' ,to: 'project#unLikePipeComment'
           
   post '/helpTab' ,to: 'help#openHelp'      
  
   post '/openAskHelp' ,to: 'help#openAskHelp'
   
   post '/openHelpOthers' ,to: 'help#openHelpOthers'
   
   get '/checkNotifications' ,to: 'notification#checkNotifications'
   
   post '/showNotifications' ,to: 'notification#showNotifications'
   
   post 'showPipe/:pipe_id' ,to: 'general_utilities#showPipe';
   
   post 'showProjectPipe/:pipe_id' ,to: 'general_utilities#showProjectPipe';
   
   post 'show_project_notification/:project_id', to: 'general_utilities#show_project_notification'
   
   post '/followerNotification' ,to: 'notification#followerNotification'
   
   post '/projectFollowerNotification/:project_id' ,to: 'notification#projectFollowerNotification'
   
   get 'show_project/:project_id', to: 'project#show_project'
   
   
      
end
