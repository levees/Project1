Rails.application.routes.draw do

  #resources :communities

  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get       "/comment/:id",         to: "comments#list",        as: "comments"
  post      "/comment/:id",         to: "comments#create"
  delete    "/comment/:cid",        to: "comments#destroy"

  get       "/:community",          to: "communities#list",     as: "community_articles" 
  post      "/:community",          to: "communities#create"             
  get       "/:community/new",      to: "communities#new",      as: "new_community_article" 
  get       "/:community/:id/edit", to: "communities#edit",     as: "edit_community_article" 
  get       "/:community/:id",      to: "communities#show",     as: "community_article" 
  patch     "/:community/:id",      to: "communities#update"                  
  put       "/:community/:id",      to: "communities#update"                  
  delete    "/:community/:id",      to: "communities#destroy"                  


  get       "/:community/:id/photo", to: "communities#photo_new",    as: "photos" 
  post      "/:community/:id/photo", to: "communities#photo_upload"
  delete    "/:community/:id/photo", to: "communities#photo_delete"

  post      "/upload/image",        to: "upload#image",         as: "upload_image"
  post      "/upload/file",         to: "upload#file",          as: "upload_file"



=begin

  get   "/:community",          to: "communities#list",       as: "community_articles"
  post  "/:community",          to: "communities#create"
  get   "/:community/new",      to: "communities#new",        as: "new_community_article"
  get   "/:community/:id/edit", to: "communities#edit",       as: "edit_community_article"
  get   "/:community/:id",      to: "communities#show",       as: "community_article"



=end

  #map.connect ":community/:id", controller: "communities"

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
