class ApplicationController < ActionController::Base
  #This function is used to authorize the user as admin. If the user is not admin it will redrect to login url
  before_filter :authorize
  before_filter :set_i18n_locale_from_params

  protect_from_forgery
  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected
  #The before_filter line causes the authorization to be invoked before every action
  #in our application.

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end



  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  #otherwise, it leaves the locale alone. Care is taken to provide a message for
  #both the user and the administrator when there is a failure.
  #And default_url_options also does pretty much what it says, in that it provides
  #a hash of URL options that are to be considered as present whenever they
  #aren’t otherwise provided. In this case, we are providing a value for the :locale
  #parameter.

  def default_url_options
    { :locale => I18n.locale }
  end
end
