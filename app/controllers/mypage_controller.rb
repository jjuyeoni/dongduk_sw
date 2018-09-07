class MypageController < ApplicationController
  def mypage
     @scraps = current_user.scraps
     @posts = current_user.posts
     @applies = current_user.applies.where("matching=?", 0) #내가 작성한 신청서-아직 매칭X
     @badunapp = Apply.where("partner = ? AND matching = ?", current_user.id, 0) #받은 신청서 -아직 매칭X
     @mapplies = Apply.where("matching = ? AND user_id =? OR matching = ? AND partner =?", 1, current_user.id, 1, current_user.id)

  end
end
