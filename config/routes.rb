Rails.application.routes.draw do


  # json api routes
  get '/weather/locations', to: 'location#all_locations'

  get '/weather/data/:post_code/:date', to: 'postcode#get_weather', constraints: { post_code: /3[0-9]{3}/, date: /(0[1-9]|[12][0-9]|3[01])[-.](0[1-9]|1[012])[-.](19|20)\d\d/ }

  get '/weather/data/:location_id/:date', to: 'location#get_weather', constraints: { date: /(0[1-9]|[12][0-9]|3[01])[-.](0[1-9]|1[012])[-.](19|20)\d\d/ }

  get '/weather/predicition/:post_code/:period', to: 'postcode#get_prediction', constraints: { post_code: /3[0-9]{3}/, period: /[10|30|60|120|180]/ }

  get '/weather/predicition/:lat/:long/:period', to: 'location#get_prediction', constraints: { lat: /[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)/, long: /[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)/, period: /[10|30|60|120|180]/ }

  # web interface routes
  get '/', to: 'home#index'
  get '/index', to: 'home#index'
  get '/weather', to: 'home#index'

  # result routing not necessary? maybe?


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
