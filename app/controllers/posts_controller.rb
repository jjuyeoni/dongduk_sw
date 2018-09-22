class PostsController < ApplicationController
    before_action :authenticate, only: [:new, :edit, :create, :update]
    
    def index
        @posts = Post.all.order("id DESC")
        unless params[:search].nil?
          @search = Post.search do
              fulltext params[:search]
          end
          @posts = @search.results.reverse
        end
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def show
        @post = Post.find(params[:id])
        if @post.user_id != current_user.id
          @apply = @post.applies.find_by(user_id: current_user.id)
        end
        @day=['일', '월', '화', '수', '목', '금', '토']
        
        @user = User.find(@post.user_id)
        
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @user = User.find(current_user.id)
        @post = @user.posts.new(post_params)
        @post.state = '-1'
        
        for i in 0..6
          @post.candays[i]= Array.new
            if params[:date][i.to_s] == nil
              @post.candays[i] << "-"
            else
              params[:date][i.to_s].each do |d|
                @post.candays[i] << d
              end
            end
        end
        
        @post.sns = params[:sns]
        @post.address[0] = params[:add1] 
        @post.address[1] = params[:add2]
        
        if @post.save
          redirect_to @post
        else
          render 'new'
        end
    end
    
    def update
      @post = Post.find(params[:id])
      
      for i in 0..6
          @post.candays[i]= Array.new
            if params[:date][i.to_s] == nil
              @post.candays[i] << "-"
            else
              params[:date][i.to_s].each do |d|
                @post.candays[i] << d
              end
            end
        end
     
        @post.address[0] = params[:add1] 
        @post.address[1] = params[:add2]
        @post.sns = params[:sns]
          
      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    end
    
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
     
      redirect_to posts_path
    end

    
    private
      def post_params
        params.require(:post).permit(:title, :content, :lat, :lon, :category, :image)
      end
      
      def authenticate
        user = User.find(current_user.id)
        if user.confirmed_portal != true
            redirect_to users_confirm_path
        end
      end
    
end
