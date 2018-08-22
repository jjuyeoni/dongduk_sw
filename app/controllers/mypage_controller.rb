class MypageController < ApplicationController
  def mypage
     @applies = current_user.applies
     @scraps = current_user.scraps
     @posts = current_user.posts
     @mapplies = Apply.where("matching = ? AND user_id =? OR matching = ? AND partner =?", 1, current_user.id, 1, current_user.id)
     @badunapp = Apply.where("partner = ?", current_user.id)
     
  end
end
