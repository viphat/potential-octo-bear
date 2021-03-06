Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'welcome#index'
  get 'books/type/:book_type' => 'books#filter_book_type'
  get 'books/search/:title' => 'books#search_by_title', as: 'search_books_by_title'
  get 'books/authors' => 'books#authors_tag'
  get 'books/get_books_json' => 'books#get_books_json'
  get 'books/title/:title' => 'books#load_book_details'
  get 'books/random' => 'books#get_random_book'

  get 'books/authors/:author' => 'books#filter_author', :author => /[^\/]+/

  get 'books/authors/:author/type/:book_type' =>
        'books#filter_author_and_book_type',
      :author => /[^\/]+/

  resources :books
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
