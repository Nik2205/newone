class HelpController < ApplicationController
  def openHelp
    render '/help_main'
  end
  
  def openAskHelp
    @user = User.find(session[:user_id])
    @pipes =Pipe.where(["created_by =? and pipe_type = ?",session[:user_id],'H'])
    @tags =Tag.all
      
    render '/ask_help'
  end
  
  def openHelpOthers
    @user = User.find(session[:user_id])
    objSuggestion = Suggestion.new(session[:user_id])
    @helpPipes = objSuggestion.pipeSuggestionForHelp
    render '/help_others'  
  end
  
end