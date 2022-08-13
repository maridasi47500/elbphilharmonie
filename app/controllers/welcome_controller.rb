class WelcomeController < ApplicationController
  protect_from_forgery except: [:editaccount,:mydata,:disableaccounthint]
  def index
    @swiper=Teaser.swiper
    @teaser=Highlight.all
    @article=Blog.firstblog
    @blogs=Blog.myblogs
  end
  def editaacount
    render layout: false
  end
  def changeemail
    current_user.email=""
    
  end
  def webshop
    render json: {}
  end
  def changepassword
    p current_user.errors
    p current_user.errors.messages.to_a
  end
  def mydata
    @user=User.new(country: "DE")
      @loginuser=User.find_by_email(params['login-email']) || User.new
      if @loginuser && @loginuser.valid_password?(params['login-password'])
        @loginuser.addfavorite(params[:afterloginbookmarkevent])
        bypass_sign_in(@loginuser)
        
        redirect_to myaccount_path
      elsif !user_signed_in?
        render "users/sessions/new", locals: {user: @loginuser}
      elsif params[:afterloginbookmarkevent]
        redirect_to myevents_path
      else
        render :mydata
      end
      
  end
  def desactivate
    render layout: false
  end
  def desactivatecustomeraccount
    render layout: false
  end
  def disableaccounthint
    render layout: false
  end
  
  def mypic
    send_file Rails.root.join("public", "mesicones.svg"), type: "image/svg", disposition: "inline"

  end
  private
  def myparams
    params.permit(:afterloginbookmarkevent, "login-email", "login-password")
  end
end
