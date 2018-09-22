class Apply < ApplicationRecord
    validates :title, :content, presence:  { message: "must be given please" }
    belongs_to :post
    belongs_to :user
    
end
