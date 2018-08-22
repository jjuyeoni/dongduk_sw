class HomeController < ApplicationController
  def index
    session[:conversations] ||= []
 
    @users = User.all.where.not(id: current_user)
    
    @applies = current_user.applies
    
   
    @badunapp = Apply.where("partner = ?", current_user.id)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end
end
