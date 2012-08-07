require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    #Should have a cart with items
    cart = Cart.create
    session[:cart_id] = cart.id
    LineItem.create(:cart_id => cart, :product_id => products(:ruby))

    get :new

    # Here
    #assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      # You have to declare all atrributes that are required to db
      post :create, :order => { :address => @order.address, :email => @order.email, :name => @order.name, :pay_type => @order.pay_type , :updated_at => @order.updated_at , :created_at => @order.created_at}
      # It will not work because it will insert duplicate id
      #post :create, :order => @order.attributes

    end

    #assert_redirected_to order_path(assigns(:order))
    assert_redirected_to store_path

  end

  test "should show order" do
    get :show, :id => @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @order
    assert_response :success
  end

  test "should update order" do
    put :update, :id => @order, :order => { :address => @order.address, :email => @order.email, :name => @order.name, :pay_type => @order.pay_type }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, :id => @order
    end

    assert_redirected_to orders_path
  end

  test "requires item in cart" do
    get :new
    assert_redirected_to store_path
    # Check the cart is empty or not
    assert_equal flash[:notice], 'Your cart is empty'
  end

end
