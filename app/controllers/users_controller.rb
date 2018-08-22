class UsersController < ApplicationController
  
  def confirm
  end
  
  # POST /users
  # POST /users.json
  def create
    receiver_email = params[:receiver_email]
    school = params[:school]
    receiver = receiver_email + school
    cookies[:random_number] = rand(1000 ..10000).to_s
    cookies[:sname] = School.find_by(schoolemail: params[:school]).schoolname
    cookies[:sid] = receiver_email
    
    
    UserMailer.send_email(receiver, cookies[:random_number]).deliver_now
    
  end

  def authen
    @authen = params[:authen]
    if cookies[:random_number] == @authen
      user = User.find(current_user.id)
      user.confirmed_portal = 1
      user.school = cookies[:sname]
      user.sid = cookies[:sid][0,4]
      user.save
      
      cookies.delete :random_number
    end
    redirect_to root_path
  end
  
end
