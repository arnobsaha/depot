#
#Whereas previously we
#relied on the scaffolding generator to create our model and routes for us, this
#time we simply generated a controller because there is no database-backed
#model for this controller. Unfortunately, without the scaffolding conventions
#to guide it, Rails has no way of knowing which actions are to respond to GET
#requests, which are to respond to POST requests, and so on, for this controller.
#We need to provide this information by editing our config/routes.rb file
#
#*** Important : So we need to write admin controller  routing to config file
class AdminController < ApplicationController
  def index
    #Find out the total orders and pass it to admin index view page
    @total_orders = Order.count
  end
end
