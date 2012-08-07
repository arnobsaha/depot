=begin
    Now that all the pieces are in place, we can go back to the store page and hit
    the Add to Cart button for a product that is already in the cart. What we are
    likely to see is a mixture of individual products listed separately and a single
    product listed with a quantity of two. This is because we added a quantity of
    1 to existing columns instead of collapsing multiple rows when possible. What
    we need to do next is migrate the data.

=end
class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(:product_id => product_id).delete_all
          # replace with a single item
          cart.line_items.create(:product_id => product_id, :quantity => quantity)
        end
      end
    end
  end

  def self.down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
    # add individual items
      line_item.quantity.times do
        LineItem.create :cart_id => line_item.cart_id,
                        :product_id => line_item.product_id, :quantity => 1
      end
      # remove original item
      line_item.destroy
    end
  end

end
