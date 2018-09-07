class User < ApplicationRecord
  mount_uploader :image, AvatarUploader
  acts_as_reader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    
    # user가 nil이라면 새로 만든다.
    if user.nil?
      #이미 있는 이메일인지 확인한다.
      email = auth.info.email
      user = User.where(:email => email).first
      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다.
        if user.nil?
          user = User.new(
            email: auth.info.email,
            # if auth.info.first_name.exists?
            #   user_name = auth.info.first_name + auth.info.last_name
            # else
            #   user_name = auth.info.name
            # end
            profile_img: auth.info.image,
            password: Devise.friendly_token[0,20]
            )
            user.save
        end
      end
    end
      
    if identity.user != user
       identity.user = user
       identity.save!
    end
     user
  end
  
  # email이 없어도 가입이 되도록 설정
  
  def email_required?
    false
  end
  
  has_many :posts
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :matposts
  has_many :reviews
  
  #스크랩
  has_many :scraps
  def is_scrap?(post) 
    Scrap.find_by(user_id: self.id, post_id: post.id).present? 
  end
  
  #지원서
  has_many :applies
  def is_apply?(post) 
    Apply.find_by(user_id: self.id, post_id: post.id).present? 
  end

  #알림
  has_many :new_notifications
  
  #def self.from_omniauth(auth)
    #where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      #user.provider = auth.provider
      #user.uid = auth.uid
      #user.name = auth.info.name
      #user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #user.save!
    #end
  #end


end
