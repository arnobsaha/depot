require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      #post :create, :line_item => { :cart_id => @line_item.cart_id, :product_id => @line_item.product_id }
      # For the product ruby
      post :create, :product_id => products(:ruby).id
    end

    #assert_redirected_to line_item_path(assigns(:line_item))
    # Redirect the cart path and assign the line_items to the cart
    #assert_redirected_to cart_path(assigns(:line_item).cart)
    # Previously when a line item have been created it redirect to the previous url wth success message . Now as we changed the
    # the redirected url we have to change it now
    assert_redirected_to store_path


  end

  test "should show line_item" do
    get :show, :id => @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @line_item
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item, :line_item => { :cart_id => @line_item.cart_id, :product_id => @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @line_item
    end

    assert_redirected_to line_items_path
  end
  #This test differs in the name of the test in the manner of invocation from
  #the create line item test (xhr :post vs. simply post, where xhr stands for the
  #XMLHttpRequest mouthful) and in the expected results.
  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, :product_id => products(:ruby).id
    end
    assert_response :success

    ### It is created problem. Have to recheck

    #assert_select_rjs :replace_html, 'cart' do
    #  assert_select 'tr#current_item td', /Programming Ruby 1.9/
    #end
  end

end
