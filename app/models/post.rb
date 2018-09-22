class Post < ApplicationRecord
    mount_uploader :image, S3Uploader
    belongs_to :user
    validates_presence_of :title, :content
    
    searchable do
      text :title, :default_boost => 2 #제목
      text :content # 내용
    end
    
    serialize :candays, Array
    serialize :address, Array
    has_many :applies
    has_many :scraps
    
    before_destroy :destroy_assets
 
    def destroy_assets
        self.image.remove! if self.image
        self.save!
    end
end
