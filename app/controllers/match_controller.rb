class MatchController < ApplicationController
  
  def index
     @address = ['전체', '강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구']
    @time = Time.now.year
    @category = ['게임','코딩','언어','뷰티','운동','음악']
    
  end
  
  def search
     @address = ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구']
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
    
    #행정구 저장
    @add = []
    if params[:address][:address].include?('전체')
      cookies[:address] = '전체'
      @add = @address
    else
      params[:address][:address].each do |a|
        @add << a
      end 
      cookies[:address] = @add
    end
    
    @users.each do |x|
      x.posts.each do |y| #각 유저가 쓴 글중에서
      if @category.include?(y.category) && @add.include?(y.address[0])
         Matpost.create(post_id: y.id, user_id: current_user.id)
       end
      end
    end
  
  
    
  
   redirect_to '/match/result'
  end

  def result
    @category = cookies[:category].split("&") 
    @result = Matpost.where(user_id: current_user.id)
    if cookies[:sex] == 'F'
      @sex = '여자'
    elsif cookies[:sex] == 'M'
      @sex = '남자'
    else
      @sex = cookies[:sex]
    end
    @start_sid = cookies[:st]
    @end_sid = cookies[:en]
    @school = cookies[:school]
    @address = cookies[:address].split("&") 
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
