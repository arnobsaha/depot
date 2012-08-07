=begin
    *** Important : The create action also creates an Order object, populating it from the form
        fields. This object does get saved in the database. So, model objects perform
        two roles: they map data into and out of the database, but they are also just
        regular objects that hold business data. They affect the database only when
        you tell them to, typically by calling save.

=end
class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy


  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  attr_accessible :address, :email, :name, :pay_type , :updated_at , :created_at , :id
  validates :name, :address, :email, :pay_type, :presence => true
  #a malicious user from submit-
  #ting form data directly to the application, bypassing our form. If the user set
  #an unknown payment type, they might conceivably get our products for free.
  validates :pay_type, :inclusion => PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end


end
