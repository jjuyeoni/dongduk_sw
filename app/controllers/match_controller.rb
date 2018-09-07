class MatchController < ApplicationController
  def index
    @time = Time.now.year
    @category = ['게임','코딩','언어','뷰티','운동','음악']
  end
  
  def search
    
    #매칭된 글 DB 초기화
    Matpost.where("user_id = ?", current_user.id).each do |a|
      a.destroy
    end
    
   
    
    #먼저 해당 유저를 찾는다
    if params[:sex] == "all" #성별이 무관일경우
      cookies[:sex] = "무관"
      @users = checkSchool(User.where.not(id: current_user.id)) #학교 학번 체크 함수호출
    else #성별 선택
      cookies[:sex] = params[:sex]
      @users = checkSchool(User.where("sex = ? AND id != ?", params[:sex], current_user.id) ) #학교 체크 함수호출
    end
    
    
    #이제 카테고리 매칭 시작
    @category = []
    #우선 카테고리 저장
    params[:category][:category].each do |a|
      @category << a
    end 
    cookies[:category] = @category
    
    @users.each do |x|
      x.posts.each do |y| #각 유저가 쓴 글중에서
       if @category.include?(y.category)
         Matpost.create(post_id: y.id, user_id: current_user.id)
       end
      end
    end
  
  
    
  
   redirect_to '/match/result'
  end

  def result
    @category = cookies[:category].split("&") 
    @result = Matpost.where(user_id: current_user.id)
    @sex = cookies[:sex]
    @start_sid = cookies[:st]
    @end_sid = cookies[:en]
    @school = cookies[:school]
  end
  
  
  def checkSchool(users) #학교 학번 체크 함수
    st = params[:st].to_i - 1
    cookies[:st] = params[:st]
    en = params[:en].to_i + 1
    cookies[:en] = params[:en]
    if params[:school] == "all" #학교 무관
        cookies[:school] = "무관"
        return users.where("sid > ? AND sid < ?", st, en)
    elsif params[:school] == "my" #학우
        cookies[:school] = "학우"
        return users.where("school = ? AND sid > ? AND sid < ?", current_user.school, st, en)
    else #타학교
        cookies[:school] = "타학교"
        return users.where("school = ?AND sid > ? AND sid < ?", current_user.school, st, en)
    end
  end
  
  
  
  
  
end
