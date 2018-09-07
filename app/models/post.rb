class Post < ApplicationRecord
    mount_uploader :image, AvatarUploader

    belongs_to :user
    validates_presence_of :title, :content
    searchable do
      text :title, :default_boost => 2 #제목
      text :content # 내용
    end
    serialize :candays, Array
    has_many :applies
    has_many :scraps
end
