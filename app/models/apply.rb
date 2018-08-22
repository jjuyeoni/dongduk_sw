class Apply < ApplicationRecord
    # posts, user에 속함
    belongs_to :post
    belongs_to :user
end
