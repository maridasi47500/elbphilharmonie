# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
    layout 'otherpage', only: [:new]

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
     @newuser = User.new
     super
   end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    if user_signed_in?
     sign_out(current_user)
    end
    
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
