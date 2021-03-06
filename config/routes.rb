Nihongofuda::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users

  authenticate :user do
    get '/search/:q' => 'search#index'
    post '/search' => 'search#index', as: :search

    scope :build do
      get '/:edict_id' => 'fuda#new', as: :new_fuda
      post '/:edict_id/create' => 'fuda#create', as: :create_fuda
    end
  end

  scope :kanji do
    get '/:literal' => 'kanji#show', as: :kanji
  end

  get '/quiz' => 'yamafuda#quiz', as: :any_quiz

  scope :deck do
    get '/:name/quiz' => 'yamafuda#quiz', as: :quiz
    get '/:name/quiz/:id/flip' => 'yamafuda#flip', as: :quiz_flip
    get '/:name/board' => 'yamafuda#board', as: :board
    get '/:name/board/study' => 'yamafuda#study_board', as: :study_board

    get '/:name/board/:continuous' => 'yamafuda#board', as: :continuous_board
    get '/:name/board/study/:continuous' => 'yamafuda#study_board', as: :continuous_study_board
  end

  get 'builder' => 'kanji#fuda_maker', as: :fuda_builder
  get 'random' => 'yamafuda#random', as: :random
  get 'yamafuda/:name' => 'yamafuda#show', as: :yamafuda_show
  get 'yamafuda/:name/continuous' => 'yamafuda#continuous_show', as: :yamafuda_continuous_show
  get 'yamafuda/:name/random' => 'yamafuda#random', as: :yamafuda_random
  get 'yamafuda/:name/:id' => 'yamafuda#front', as: :yamafuda_front
  get 'yamafuda/:name/:id/flip' => 'yamafuda#flip', as: :yamafuda_flip

  # You can have the root of your site routed with "root"
  root 'application#index'

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
