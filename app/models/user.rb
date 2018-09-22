class User < ApplicationRecord
  mount_uploader :profile_img, S3Uploader
  acts_as_reader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :naver]
  
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
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.sex = auth.info.gender
        user.profile_img = auth.info.profile_img
        user.password = auth.info.email
        user.save!
      end
    end
  end
end
