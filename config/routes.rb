App::Application.routes.draw do

  get "page/home", :to => "page#home"
  get "page/saved", :to => "page#saved"
  get "/terms_of_service", :to => 'page#terms_of_service'
  get "/buttons", :to => 'page#buttons'
  get "/privacy", :to => 'page#privacy'
  get "/contact", :to => 'page#contact'
  get "/about", :to => 'page#about'

  get "modal/report_tag", :to => "page#report_tag"
  get "modal/report_item", :to => "page#report_item"
  get "modal/relift", :to => "page#relift"

  get '/shoplifters', :to => 'users#index'

  #resources :images TODO delete this and any other image artifacts
  resources :posts
  resources :categories, :only => [:index, :edit, :update]
  post "categories/:id/update", :to => "categories#update"  
  get "post/create", :to => "posts#create"
  post "posts/:id/update", :to => "posts#update"

  root :to => "page#home"

  #
  # Users
  #
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks" } #, :skip => [:registrations,:passwords,:unlocks]
  # makes domain/login work as well as domain/users/login
  devise_scope :user do
    get "login"  => "devise/sessions#new"
    get "logout" => "devise/sessions#destroy"
    #delete "logout" => "devise/sessions#destroy"
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  resources :users, :only => [:show,:create,:update,:destroy] do
    resources :followers, :only => [:index]
    resources :following, :only => [:index]
  end
  get "users/validate_username/:username", :to => "users#validate_username"
  get "users/username/:username", :to => "users#show", :identifier => "username"
  # Browser / system compatability
  post "users/:id/edit", :to => "users#update"
  post "users/:id/delete", :to => "users#destroy"

  #
  # Timelines
  #
  get "timelines", :to => "timelines#index"
  get "timelines/users/:id", :to => "timelines#show_user"
  get "timelines/recent", :to => "timelines#show_recent"
  get "timelines/hashtags/:name", :to => "timelines#show_hashtags"

  #
  # Parser and Bookmarklet
  #
  get "bookmarklet", :to => "parser#bookmarklet"
  post "parse", :to => "parser#parse"

  #
  # Items
  #
  resources :items do
    member do
      get :image, :visit
      post :relift
    end
    get :search, :on => :collection
    resources :hashtags, :only => [:create]
  end
  # # Browser / system compatability
  post "items/:id/edit", :to => "items#update"
  post "items/:id/delete", :to => "items#destroy"

  get "createItem", :to => "items#create"

  #
  # Hashtags
  #
  get "hashtags/popular", :to => "hashtags#show_popular"
  get "hashtags/search", :to => "hashtags#search"
  delete "hashtags/:id" => "hashtags#destroy"
  post "hashtags/create", :to => "hashtags#create"
  # Browser / system compatability
  post "hashtags/:id/delete" => "hashtags#destroy"

  #
  # Subscriptions
  #
  get "subscriptions", :to => "subscriptions#index"
  get "subscriptions/users/:id", :to => "subscriptions#show"
  post "subscriptions", :to => "subscriptions#create"
  delete "subscriptions/users/:id", :to => "subscriptions#destroy"
  # Browser / system compatability
  post "subscriptions/users/:id/delete", :to => "subscriptions#destroy"

  #
  # Suggestions
  #
  get "suggestions", :to => "suggestions#index"

  #
  # Set Asides
  #
  get "set_asides", :to => "set_asides#index"
  post "set_asides", :to => "set_asides#create"
  delete "set_asides/items/:id", :to => "set_asides#destroy"
  # Browser / system compatability
  post "set_asides/items/:id/delete", :to => "set_asides#destroy"

  #
  # Flags
  #
  get "flags", :to => "flags#index"
  post "flags/items/:id", :to => "flags#create_item"
  post "flags/hashtags/:id", :to => "flags#create_hashtag"

  #
  # Statistics
  #
  get "statistics/users/:id", :to => "statistics#show_user"
  get "statistics/items/:id", :to => "statistics#show_item"

  #
  #Error Handling
  #
  match "/", :to => "application#render_error", :status => 404
  match "*path", :to => "application#render_error", :status => 404

end
