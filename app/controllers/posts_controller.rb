class PostsController < ApplicationController
    before_action :authenticate, only: [:new, :edit, :create, :update]
    
    def index
        @posts = Post.all
        @search = Post.search do
            fulltext params[:search]
        end
        @posts = @search.results.reverse
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
        
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @user = User.find(current_user.id)
        @post = @user.posts.new(post_params)
        @tmp = Array.new
        for i in 0..6
        @post.candays[i]= Array.new
        if params[:date][i.to_s] == nil
          @post.candays[i] << "없다요"
        else
          params[:date][i.to_s].each do |d|
            @post.candays[i] << d
          end
        end
        end
        
        if @post.save
            redirect_to @post
        else
            render 'new'
        end
    end
    
    def update
      @post = Post.find(params[:id])
     
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
    
    def upload
      Post.upload(content: params[:content],
                            image: params[:image])
      redirect_to :back
    end
    
    private
      def post_params
        params.require(:post).permit(:title, :content, :lat, :lon, :category, :add, :image)
      end
      
      def authenticate
        user = User.find(current_user.id)
        if user.confirmed_portal != true
            redirect_to users_confirm_path
        end
    end
end
