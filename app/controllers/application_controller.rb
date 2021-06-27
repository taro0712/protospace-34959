class ApplicationController < ActionController::Base

  
  #ここで行われる処理はログインユーザーによってのみ実行可能
  #ログインしていないユーザーをログインページの画面に促すことができる
  # before_action :authenticate_user! 
   before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password,:encrypted_password, :name, :profile, :occupation, :position])

  end

end
