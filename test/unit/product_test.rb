=begin
    The unit testing of models that we did previously seemed straightforward
    enough. We called a method and compared what it returned against what
    we expected it to return. But now we are dealing with a server that processes
    requests and a user viewing responses in a browser. What we will need is functional
   tests that verify that the model, view, and controller work well together.

=end
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
=begin
    *** Important : we want Rails to load the test data into the
      products table when we run the unit test. And, in fact, Rails is already doing
      this (convention over configuration for the win!), but you can control which
      fixtures to load by specifying the following line in test/unit/product_test.rb:
        fixtures :products
    *** Each time unit test run products from the fixtures have been reloaded
      The fixtures directive loads the fixture data corresponding to the given model
      name into the corresponding database table before each test method in the
      test case is run. The name of the fixture file determines the table that is loaded,
      so using :products will cause the products.yml fixture file to be used.
      Let’s say that again another way. In the case of our ProductTest class, adding
      the fixtures directive means that the products table will be emptied out and then
      populated with the three rows defined in the fixture before each test method
      is run.

=end
=begin
 *** Important : An assertion is
      simply a method call that tells the framework what we expect to be true. The
      simplest assertion is the method assert, which expects its argument to be true.
      If it is, nothing special happens. However, if the argument to assert is false, the
      assertion fails. The framework will output a message and will stop executing
      the test method containing the failure. In our case, we expect that an empty
      Product model will not pass validation, so we can express that expectation by
      asserting that it isn’t valid.
          assert product.invalid?

=end
  # test "the truth" do
  #   assert true
  # end

  # Check the unit fo a non-empty product value
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  # Write a test to check the product string length ten characters lonf
=begin
  test "product title must be ten character long" do
     product = Product.new(:title => "My product",#products(:ruby).title,
                           :description => "yyy",
                           :image_url => "zzz.jpg")
     assert product.invalid?
     assert_equal "minimum 5 chars and maximum 10 chars ",
                  product.errors[:title].join('; ')
  end
=end
  # Another validation for product price
=begin
  *** Important : In this code we create a new product and then try setting its price to -1, 0,
and +1, validating the product each time. If our model is working, the first two
should be invalid, and we verify the error message associated with the price
attribute is what we expect. Because the list of error messages is an array, we
use the handy join1 method to concatenate each message, and we express the
assertion based on the assumption that there is only one such message.
The last price is acceptable, so we assert that the model is now valid. (Some
folks would put these three tests into three separate test methods—that’s perfectly reasonable.)

=end
  test "product price must be positive" do
    product = Product.new(:title => "My Book Title",
                          :description => "yyy",
                          :image_url => "zzz.jpg")
    # If the test is true then and the assertion is invalid return true
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')
    # If the test is true and the assertion is invalid  then return true
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')
    # If the test is true and the assertion is valid  then return true
    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(:title => "My Book Title",
                :description => "yyy",
                :price => 1,
                :image_url => image_url)
  end

  # Test to check the image url validation
=begin
    *** Important : Here we’ve mixed things up a bit. Rather than write out the nine separate
    tests, we’ve used a couple of loops—one to check the cases we expect to pass
    validation and the second to try cases we expect to fail. At the same time, we
    factored out the common code between the two loops.
    You’ll notice that we’ve also added an extra parameter to our assert method
    calls. All of the testing assertions accept an optional trailing parameter containing
   a string. This will be written along with the error message if the assertion fails and can be useful for diagnosing what went wrong.

=end
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
   http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  # If product does not have unique title then it will not be saved and return true
  test "product is not valid without a unique title" do
    product = Product.new(:title => products(:ruby).title,
                          :description => "yyy",
                          :price => 1,
                          :image_url => "fred.gif")


    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end
=begin
  ** Explanation :
  The test assumes that the database already includes a row for the Ruby book.
It gets the title of that existing row using this:
products(:ruby).title

It then creates a new Product model, setting its title to that existing title. It
asserts that attempting to save this model fails and that the title attribute has
the correct error associated with it.
If you want to avoid using a hard-coded string for the Active Record error, you
can compare the response against its built-in error message table:
=end
  test "product is not valid without aunique title - i18n" do
    product = Product.new(:title => products(:ruby).title,
                          :description => "yyy",
                          :price => 1,
                          :image_url => "fred.gif")


    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors[:title].join('; ')
  end

end
