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
  get "users/validate_username/:username", :to => "users#validate_username", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "users/username/:username", :to => "users#show", :identifier => "username", :defaults => { :format => :json }, :constraints => {:format => :json}
  # Browser / system compatability
  post "users/:id/edit", :to => "users#update", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "users/:id/delete", :to => "users#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}

  get "recommended", :to => "users#recommended"
  get "staff_picks", :to => "users#staff_picks"
  get "popular", :to => "users#popular"
  get "trending", :to => "users#trending"
  get "local_favorites", :to => "users#local_favorites"
  get "friends", :to => "users#friends"
  get "staff_picks", :to => "users#staff_picks"

  #
  # Timelines
  #
  get "timelines", :to => "timelines#index"
  get "timelines/users/:id", :to => "timelines#show_user", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "timelines/recent", :to => "timelines#show_recent", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "timelines/hashtags/:name", :to => "timelines#show_hashtags", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Parser and Bookmarklet
  #
  get "bookmarklet", :to => "parser#bookmarklet", :constraints => {:format => :js}
  post "parse", :to => "parser#parse", :defaults => { :format => :json }, :constraints => {:format => :json}

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
  post "items/:id/edit", :to => "items#update", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "items/:id/delete", :to => "items#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}

  get "createItem", :to => "items#create", :defaults => { :format => :html }

  #
  # Hashtags
  #
  get "hashtags/popular", :to => "hashtags#show_popular", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "hashtags/search", :to => "hashtags#search", :defaults => { :format => :json }, :constraints => {:format => :json}
  delete "hashtags/:id" => "hashtags#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "hashtags/create", :to => "hashtags#create", :defaults => { :format => :json }, :constraints => {:format => :json}
  # Browser / system compatability
  post "hashtags/:id/delete" => "hashtags#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Subscriptions
  #
  get "subscriptions", :to => "subscriptions#index", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "subscriptions/users/:id", :to => "subscriptions#show", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "subscriptions", :to => "subscriptions#create", :defaults => { :format => :json }, :constraints => {:format => :json}
  delete "subscriptions/users/:id", :to => "subscriptions#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}
  # Browser / system compatability
  post "subscriptions/users/:id/delete", :to => "subscriptions#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Suggestions
  #
  get "suggestions", :to => "suggestions#index", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Set Asides
  #
  get "set_asides", :to => "set_asides#index", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "set_asides", :to => "set_asides#create", :defaults => { :format => :json }, :constraints => {:format => :json}
  delete "set_asides/items/:id", :to => "set_asides#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}
  # Browser / system compatability
  post "set_asides/items/:id/delete", :to => "set_asides#destroy", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Flags
  #
  get "flags", :to => "flags#index", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "flags/items/:id", :to => "flags#create_item", :defaults => { :format => :json }, :constraints => {:format => :json}
  post "flags/hashtags/:id", :to => "flags#create_hashtag", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  # Statistics
  #
  get "statistics/users/:id", :to => "statistics#show_user", :defaults => { :format => :json }, :constraints => {:format => :json}
  get "statistics/items/:id", :to => "statistics#show_item", :defaults => { :format => :json }, :constraints => {:format => :json}

  #
  #Error Handling
  #
  match "/", :to => "application#render_error", :status => 404
  match "*path", :to => "application#render_error", :status => 404

end
