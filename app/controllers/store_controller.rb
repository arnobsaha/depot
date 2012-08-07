class StoreController < ApplicationController
  #This is used to skip the :authorize when this controller called. Its called white listing
  #By specifying which controller needs authorize  is called blacklisting
  #and is prone to errors of omission. A much better approach is to “whitelist” or
  #list methods or controllers for which authorization is not required. We do this
  #simply by inserting a skip_before_filter call within the StoreController


  skip_before_filter :authorize

  def index
    # It is used to load all of our products
    #@products = Product.all

    #Now we have to make a small change to the store controller. We’re invoking
    #the layout while looking at the store’s index action, and that action doesn’t
    #currently set @cart.

    #@cart = current_cart

    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.all
      @cart = current_cart
    end


  end

  # To count the number of access of user store
  def increment_count
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end

  def add_to_cart
    # ...
    session[:counter] = 0
  end

  protected

end
