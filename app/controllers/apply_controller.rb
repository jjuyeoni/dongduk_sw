class ApplyController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  
  def index
    @post = Post.find(params[:post_id])
    
  end
  
  def new
    @post = Post.find(params[:post_id])
  end
  
  def create
    
    @post = Post.find(params[:post_id])
    
    Apply.create(user_id: current_user.id, post_id: params[:post_id], matching: 'false', partner: @post.user_id, title: params[:apply][:title], content: params[:apply][:content])
      
      #신청서 왔다는 알람
      @new_notification = NewNotification.create! user: @post.user,
                                         content: "#{current_user.id}님이 신청서를 보냈습니다.",
                                         link: post_path(@post)
    
    redirect_to "/posts/#{@post.id}"
  end
  
  
  def destroy
    @post = Post.find(params[:post_id])
    @apply = Apply.find_by(user_id: current_user.id, post_id: params[:post_id])
    @apply.destroy
    @noti = NewNotification.find_by(user: @post.user, content: "#{current_user.id}님이 신청서를 보냈습니다.")
    @noti.destroy
    
    redirect_to "/posts/#{@post.id}"
  end
  
  def edit
      @apply = Apply.find(params[:apply_id])
  end
    
  def update
    @apply = Apply.find(params[:apply_id])
    @apply.title = params[:apply][:title]
    @apply.content = params[:apply][:content]
    @apply.save
    
    redirect_to "/apply/show/#{@apply.id}"
  end
  
  def show
    @apply = Apply.find(params[:apply_id])
  end
  
 def apply_accept
   @post = Post.find(params[:post_id])
   @apply = @post.applies.find(params[:apply_id])
   @apply.matching = "true"
   @apply.save
   
   
   #신청서 수락받았다는 알람
      @new_notification = NewNotification.create! user: @apply.user,
                                         content: "#{@post.user.id}님이 신청서를 수락했습니다.",
                                         link: post_path(@post)
    else
   redirect_to "/apply/index/#{params[:post_id]}/"
 end
 
 
end
