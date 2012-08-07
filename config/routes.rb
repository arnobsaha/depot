Depot::Application.routes.draw do
  # Define the admin url.It will define the url as admin_url
  get 'admin' => 'admin#index'
  #Create custom route
  controller :sessions do
    # It will call te new action of session . As we do not specify any session new action it will load the view page. It will also worked for /login route as we defined
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end


  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

=begin
    What we have done is nested our resources and root declarations inside a
    scope declaration for :locale. Furthermore, :locale is in parentheses, which is
    the way to say that it is optional. Note that we did not choose to put the
    administrative and session functions inside this scope, because it is not our
    intent to translate them at this time.

=end
  scope '(:locale)' do

    resources :users

    resources :orders

    resources :line_items

    resources :carts

    get "store/index"

    #resources :products
    resources :products do
      get :who_bought, :on => :member
    end


    # ...
    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.
    # root :to => "welcome#index"
    root :to => 'store#index', :as => 'store'

  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
