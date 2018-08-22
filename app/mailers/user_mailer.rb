class UserMailer < ApplicationMailer
    default :from => "fishsong2@gmail.com"
    
    def send_email(receiver, random_number)
        @receiver = receiver
        @random_number = random_number
        mail(:to => @receiver, 
             :subject => "회원 인증을 위한 안내")
    end
end
