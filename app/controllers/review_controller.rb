class ReviewController < ApplicationController
    def new
        @user_id = params[:u_id]
    end
    
    def create
        user = User.find(params[:u_id])
        review = user.reviews.create(user_id: params[:u_id], writer: current_user.id, rate: params[:rate], content: params[:content])
        review.save
        
        totalrate = 0
        user.reviews.each do |a|
            totalrate += a.rate
        end
        
        user.rate = totalrate / user.reviews.count
        user.save
        
        
        redirect_to '/mypage/mypage'
    end
    
    def index
        @user = User.find(params[:u_id])
    end
end
