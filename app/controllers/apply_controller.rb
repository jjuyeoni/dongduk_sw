class ApplyController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @post = Post.find(params[:post_id])
    
  end
  
  def new
    @post = Post.find(params[:post_id])
    @apply = Apply.new

  end
  
  def create
    @post = Post.find(params[:post_id])
    
    apply = Apply.new(user_id: current_user.id, post_id: params[:post_id], matching: 'false', partner: @post.user_id, title: params[:apply][:title], content: params[:apply][:content])
    if apply.save
      #신청서 왔다는 알람
      @new_notification = NewNotification.create! user: @post.user,
                                         content: "#{current_user.id}님이 신청서를 보냈습니다.",
                                         link: post_path(@post)
                                         
                                         
                                 
                                    
      redirect_to "/posts/#{@post.id}"
    else
        render plain: apply.errors.messages
        #정말 모르겠쓰ㅃ니
    end
  end
  
  
  def destroy
    @post = Post.find(params[:post_id])
    @apply = Apply.find(params[:a_id])
    @apply.destroy
    @noti = NewNotification.find_by(user: @post.user, content: "#{@apply.user_id}님이 신청서를 보냈습니다.")
    @noti.destroy
    
    redirect_to "/posts/#{@post.id}"
  end
  
  
  def show
    @apply = Apply.find(params[:apply_id])
  end
  
 def apply_accept
   @post = Post.find(params[:post_id])
   @apply = @post.applies.find(params[:apply_id])
   @apply.matching = "true"
   @apply.save
   @post.state = @apply.user.id
   @post.save
   
   #신청서 수락받았다는 알람
      @new_notification = NewNotification.create! user: @apply.user,
                                         content: "#{@post.user.id}님이 신청서를 수락했습니다.",
                                         link: post_path(@post)
                                         
      
    
   redirect_to "/posts/#{@post.id}"
 end
 
 
end
