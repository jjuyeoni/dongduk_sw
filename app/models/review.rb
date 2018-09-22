class Review < ApplicationRecord
     belongs_to :user
     validates_presence_of :writer, :rate, :content
end
