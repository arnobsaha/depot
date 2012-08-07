#A cart may contain several producs. And a product may have in several carts. Depending on that relationship here we generate the
#LineItem scaffolding

#***Important : Rails identifies model objects (and the
#corresponding database rows) by their id fields. If we pass an id to create, we’re
#uniquely identifying the product to add.

#*** Important: The database now has a place to store the relationships between line items,
#carts, and products. However, the Rails application does not. We need to add
#some declarations to our model files that specify their interrelationships.

class LineItemsController < ApplicationController
  skip_before_filter :authorize, :only => :create

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    #Now let’s modify the LineItemsController to find the shopping cart for the current
    #session (creating one if there isn’t one there already), add the selected product
    #to that cart, and display the cart contents.

    # Line item will be created from adding Product to the Cart
    #@line_item = LineItem.new(params[:line_item])

    #current_cart is the function/method define n the ApplicationController
    @cart = current_cart
    product = Product.find(params[:product_id])
=begin
    We then pass that product we found into @cart.line_items.build. This causes a
    new line item relationship to be built between the @cart object and the product.
    You can build the relationship from either end, and Rails will take care of
    establishing the connections on both sides.

=end
    # *** Here :product_id reference the cart product_id. So that we an find out the specific product from the cart
    #@line_item = @cart.line_items.build(:product_id => product)
    #p("Product Id : "+product.id)
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        #format.html { redirect_to @line_item, :notice => 'Line item was successfully created.' }
        # Redirect t line_item cart after saving it
        #format.html { redirect_to(@line_item.cart, :notice => 'Line item was successfully created.') }
        # This function is used to redirect to store_url after saving
        format.html { redirect_to(store_url) }
        #For ajax calling , The first change is to stop the create action from redirecting to the index dis-
        #play if the request is for JavaScript. We do this by adding a call to respond_to
        #telling it that we want to respond with a format of .js.

        format.js { @current_item = @line_item }

        format.xml { render :xml => @line_item,
                            :status => :created, :location => @line_item }

        # For rendering no template
        #render :nothing => true
        #format.json { render :json => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @line_item.errors,
                            :status => :unprocessable_entity }

        #format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, :notice => 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  #Steps:
  #1. To add ajax first add format.js to controller destroy function
  #2. Then at _line_item.html.erb we add :remote => true SO that it can be called the ajax function when click
  #3. At line_items destroy.js.erb Write  necessary javascript function to delte that row
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.js
      format.json { head :no_content }
    end
  end
end
