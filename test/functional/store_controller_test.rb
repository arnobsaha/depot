require 'test_helper'

class StoreControllerTest < ActionController::TestCase
#The should get index test gets the index and asserts that a successful response
#is expected. That certainly seems straightforward enough. That’s a reasonable
#beginning, but we also want to verify that the response contains our layout,
#our product information, and our number formatting.
#
  test "should get index" do
    get :index
    assert_response :success
=begin
    The four lines we added take a look into the HTML that is returned, using
    CSS selector notation. As a refresher, selectors that start with a number sign
    (#) match on id attributes, selectors that start with a dot (.) match on class
    attributes, and selectors that contain no prefix at all match on element names.
    So, the first select test looks for an element named a that is contained in an
    element with an id with a value of side, which is contained within an element
    with an id with a value of columns. This test verifies that there are a minimum
    of four such elements. Pretty powerful stuff, assert_select, eh?
    The next three lines verify that all of our products are displayed. The first
    verifies that there are three elements with a class name of entry inside the
    main portion of the page. The next line verifies that there is an h3 element
    with the title of the Ruby book that we had entered previously. The third line
    verifies that the price is formatted correctly. These assertions are based on the
    test data that we had put inside our fixtures:

    If you noticed, the type of test that assert_select performs varies based on the
    type of the second parameter. If it is a number, it will be treated as a quantity.
    If it is a string, it will be treated as an expected result.

=end
    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/

  end

end
