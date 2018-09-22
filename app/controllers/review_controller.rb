class ReviewController < ApplicationController
    def new
        @user_id = params[:u_id]
        @apply_id = params[:a_id]
        @db = params[:db]
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
        
        #1이면 신청서 2면 글
        if (params[:db] == 1)
            @app = Apply.find(params[:a_id])
            @app.destroy
        else
            @post = Post.find(params[:a_id])
            @post.state = 0
            @post.save
        end
        
        redirect_to "/mypage"
        
    end
    
    def index
        @user = User.find(params[:u_id])
    end
end
