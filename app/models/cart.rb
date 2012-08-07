class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
=begin
    That has_many :line_items part of the directive is fairly self-explanatory: a cart
    (potentially) has many associated line items. These are linked to the cart
    because each line item contains a reference to its cart’s id. The :dependent
    => :destroy part indicates that the existence of line items is dependent on the
    existence of the cart. If we destroy a cart, deleting it from the database, we’ll
    want Rails also to destroy any line items that are associated with that cart.
=end
  has_many :line_items, :dependent => :destroy

=begin
    Now we need a smart add_product method in our Cart, one that checks whether
    our list of items already includes the product we’re adding; if it does, it bumps
    the quantity, and if it doesn’t, it builds a new LineItem:
=end
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    #p("Current Item : "+current_item)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  #Function is used to find out the total items
  def total_items
    line_items.sum(:quantity)
  end

end
