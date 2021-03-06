Rails.application.routes.draw do
  root 'posts#index'
  get 'home/index'
  get 'register/info' # 로그인한 후 화면
  get '/mypage' => 'mypage#mypage' # 마이페이지
  post '/img_save' => 'mypage#img_save'
  get 'about/about'
  post 'mypage/update_info'
  get 'mypage/edit_info' # 정보 수정

  # 소셜 로그인 시 callbacks 지정
  devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }
  
  resources :posts
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  
  #실시간채팅 액션케이블
  mount ActionCable.server => '/cable'
  
  #신청서
  post 'apply/new/:post_id' => 'apply#new'
  post 'apply/create', as: 'apply_cre'
  get 'apply/destroy/:post_id/:a_id' => 'apply#destroy'
  get 'apply/show/:apply_id' => 'apply#show'
  
  #신청서 수락
  get '/post/:post_id/apply_accept/:apply_id' => 'apply#apply_accept'
  
  #신청서 리스트
  get 'apply/index/:post_id' => 'apply#index'
  
  #스크랩
  post 'post/:post_id/scrap' => 'scrap#scrap_toggle'
  
  #알림
  get '/new_notifications/read_all' => 'new_notifications#read_all'
  resources :new_notifications
  
  #매칭
  get 'match/index'
  get 'match/result'
  post 'match/search'
  
  # 메일 인증
  get 'users/confirm'
  post 'users/create' => 'users#create'
  post 'users/send' => 'users#confirm'
  post 'users/authen' => 'users#authen'
  
  #후기작성
  get ':db/:a_id/:u_id/review/new' => 'review#new'
  post ':db/:a_id/:u_id/review/create' => 'review#create'
  

end
