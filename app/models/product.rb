class Product < ActiveRecord::Base
  # To order by default on title
  default_scope :order => 'title'
=begin
    We should add a has_many directive to our Product
    model. After all, if we have lots of carts, each product might have many line
    items referencing it. This time, we will make use of validation code to prevent
    removal of products that are referenced by line items.
=end
  has_many :line_items
  #The relationship  is indirect. Products have many line_items and line_items belong to a order.

  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
#...

# ensure that there are no line items referencing this product
=begin
    *** Explanation: Here we declare that a product has many line items and define a hook method
    named ensure_not_referenced_by_any_line_item. A hook method is a method that
    Rails calls automatically at a given point in an object’s life. In this case, the
    method will be called before Rails attempts to destroy a row in the database.
    If the hook method returns false, the row will not be destroyed.

    Note that we have direct access to the errors object. This is the same place that
    the validates stores error messages.
    *** Errors can be associated with individual
    attributes, but in this case we associate the error with the base object itself.

=end
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  public
  attr_accessible :description, :image_url, :price, :title
=begin
  *** This following rules will validate the fields.
      The following validations have been added here --
      • The field’s title, description, and image URL are not empty.
      • The price is a valid number not less than $0.01.
      • The title is unique among all products.
      • The image URL looks reasonable.

=end
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
# Add validation rules fr length by myself for checking the length
#validates :title, :length => {:maximum => 10,
#    :minimum => 5
#}
  validates :image_url, :format => {
      :with => %r{\.(gif|jpg|png)$}i,
      #If we want we cn change the error message
      :message => 'must be a URL for GIF, JPG or PNG image.'
  }

end
