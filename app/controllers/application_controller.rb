class ApplicationController < ActionController::Base
    # layout :layout_by_resource
    before_action :authenticate_user!, only: [:show, :new, :edit, :create, :update, :destroy] # 모든 페이지에서 로그인 해야함
    # before_action: authentication_user!
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 회원가입 할 때
        devise_parameter_sanitizer.permit(:account_update, keys: [:name]) #회원 정보 수정할 때
        devise_parameter_sanitizer.permit(:sign_up, keys: [:sex]) # 회원가입 할 때
        devise_parameter_sanitizer.permit(:account_update, keys: [:sex]) #회원 정보 수정할 때
        devise_parameter_sanitizer.permit(:sign_up, keys: [:instagram]) # 회원가입 할 때
        devise_parameter_sanitizer.permit(:account_update, keys: [:instagram]) #회원 정보 수정할 때
        devise_parameter_sanitizer.permit(:sign_up, keys: [:twitter]) # 회원가입 할 때
        devise_parameter_sanitizer.permit(:account_update, keys: [:twitter]) #회원 정보 수정할 때
    end

end
