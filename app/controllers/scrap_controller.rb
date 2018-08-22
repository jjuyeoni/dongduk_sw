class ScrapController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def scrap_toggle
        scrap = Scrap.find_by(user_id: current_user.id, post_id: params[:post_id])
   
        if scrap.nil?
            Scrap.create(user_id: current_user.id, post_id: params[:post_id])
        else
            scrap.destroy
        end
    
        redirect_to "/posts/#{params[:post_id]}/"
    end
end
