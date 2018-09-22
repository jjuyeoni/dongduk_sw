class MypageController < ApplicationController
  def mypage
    @user = User.find(id=current_user.id)
    @scraps = @user.scraps
    @posts = @user.posts
    @applies = @user.applies.where("matching=?", 0) #내가 작성한 신청서-아직 매칭X
    @badunapp = Apply.where("partner = ? AND matching = ?", @user.id, 0) #받은 신청서 -아직 매칭X
    @matchinguser = @user.applies.where("matching =?", 1)#내가 쓴 신청서
    @matchinguser2 = @user.posts.where("state != ?", -1)#내가 받은 신청서
  end
  
  def img_save
      @user = User.find(id=current_user.id)
      @user.profile_img = params[:profile_img]
      @user.save
      mypage
  end
  
  def edit_info
    @user = User.find(id=current_user.id)
  end
  
  def update_info
    @user = User.find(id=current_user.id)
    @user.sex = params[:sex]
    @user.save
    redirect_to '/mypage'
  end
  
end
