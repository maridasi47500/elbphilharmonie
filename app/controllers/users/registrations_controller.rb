# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create2
    @loginuser=User.new(country: "DE", :afterloginbookmarkevent => params[:afterloginbookmarkevent])
     @user=User.new({country: "DE"}.merge(configure_sign_up_params).merge({:afterloginbookmarkevent => params[:afterloginbookmarkevent]}))
     p paramsloginemail.values
     if paramsloginemail.values.length > 0 && paramsloginemail.values.all?{|x|x == ""}
        p "email blank"
       @loginuser.errors.add(:email, :blank)
        @loginuser.errors.add(:password, :blank)
        render "users/sessions/new", locals: {user: @user} 
     elsif params['login-email'] 
      if (@loginuser=User.find_by_email(params['login-email']) || User.new(country: "DE")) && @loginuser.valid_password?(params['login-password'])
        @loginuser.addfavorite(params[:afterloginbookmarkevent])
        bypass_sign_in(@loginuser)
        redirect_back fallback_location: myevents_path
      else
        @loginuser.errors.add(:base, "Error")
        render "users/sessions/new", locals: {user: @user} 
      end
     elsif @user.save
      @user.addfavorite(params[:afterloginbookmarkevent])
      bypass_sign_in(@user)
      p @user.errors
      redirect_back fallback_location: root_path
     else
       p @user.errors
       @user.errors.add(:base, t('my.messages.mydata')) if @user.errors.details.values[0].pluck(:error).any?{|g|:taken}
       @user.errors.add(:base, t('my.messages.mydatainvalid')) if @user.errors.details.values[0].pluck(:error).any?{|g|g != :email && g != :password}
       render "users/sessions/new", locals: {user: @user}
     end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end
  def updatepw
      if current_user.update(configure_account_update_params)
        bypass_sign_in(current_user)
        render "welcome/changepasswordsuccess"
      else 
        bypass_sign_in(current_user)
        p current_user.errors
        render "welcome/changepassword"
      end
  rescue NoMethodError
    
    render "welcome/changepassword", locals: {current_user: User.new}
  end
  # PUT /resource
  def update
         current_user.update(configure_account_update_params)
     bypass_sign_in(current_user)
     redirect_back fallback_location: myaccount_path

  end  
  def updateemail
    current_user.define_singleton_method(:password_required?) { false }
    current_user.email=params[:email]
    current_user.savemyemail
         if current_user.save
     bypass_sign_in(current_user)
     render "welcome/changeemailsuccess"
         else
     bypass_sign_in(current_user)
        p current_user.errors
           render "welcome/changeemail"
         end

  end  
  def updatenews
          current_user.update(configure_account_update_params.merge("news"=>"true"))
     bypass_sign_in(current_user)
     redirect_back fallback_location: myaccount_path

  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def paramsloginemail
    params.permit('login-email', "login-password")
  end
   def configure_sign_up_params
     params.permit(:afterloginbookmarkevent,"address-gender","password2", "address-title", "first_name",:title,:gender, :last_name,"address-last-name", "street", "zip_code", "city", "country", "phone", "birthday", "email", "cbCorrection", "email_repetition", "password")
   end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    params.permit(:afterloginbookmarkevent, :email,"list-1","list-2",:password1,"password2","list-3", :gender, :title, :first_name, :last_name, :street, :zip_code, :city, :country, :phone, :birthday).to_h.to_a.map {|a,b| [a.gsub("-", "_"), b]}.to_h
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
