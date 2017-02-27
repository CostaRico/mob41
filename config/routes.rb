Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
  Spree::Core::Engine.routes.append do
    resources :call_messages, only: [:new, :create]
    namespace :admin, path: Spree.admin_path do
      resources :call_messages
      resources :providers
    end
  end
          # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/orders/remove_item" => "spree/orders#remove_line_item"
	get '*id', :to => 'spree/taxons#show', :as => :categories
  #resources :call_messages#, :only => [:create, :new]
end
