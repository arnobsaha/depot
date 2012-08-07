class LineItem < ActiveRecord::Base
  #Next, we’ll specify links in the opposite direction, from the line item to the carts
  #and products tables.
=begin
    *** belongs_to tells Rails that rows in the line_items table are children of rows in
    the carts and products tables. No line item can exist unless the corresponding
    cart and product rows exist. There’s an easy way to remember where to put
    belongs_to declarations: if a table has foreign keys, the corresponding model
    should have a belongs_to for each.

=end
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  attr_accessible :cart_id, :product_id ,:quantity  , :order_id

  def total_price
    product.price * quantity
  end

end
