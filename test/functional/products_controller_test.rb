require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    #This have been added as the product already existed when we create validation rules it miss-match the validation criterion
    # the data that we already inserted    . AT test/fixtures/products.yml at product :one there have image file
    #do not have extension of required to validate. S it creates the functional testing error
    @update = {
        :title => 'Lorem Ipsum',
        :description => 'Wibbles are fun!',
        :image_url => 'lorem.jpg',
        :price  => 19.95
    }

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      #post :create, :product => { :description => @product.description, :image_url => @product.image_url, :price => @product.price, :title => @product.title }
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product
    assert_response :success
  end

  test "should update product" do
    #put :update, :id => @product, :product => { :description => @product.description, :image_url => @product.image_url, :price => @product.price, :title => @product.title }
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product
    end

    assert_redirected_to products_path
  end
end
