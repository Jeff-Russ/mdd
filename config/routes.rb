Rails.application.routes.draw do
  

#### everything below from Boxroom ####

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "folders#index"

  # Resources
  resources :admins, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :reset_password, :except => [:index, :show, :destroy]
  resources :signup, :only => [:edit, :update]
  resources :groups, :except => :show
  resources :files, :except => [:index, :new, :create]
  resources :share_links, :only => [:index, :show, :destroy]

  resources :users, :except => :show do
    put :extend, :on => :member
  end

  resources :clipboard, :only => [:create, :destroy] do
    post :copy, :on => :member
    post :move, :on => :member
    put :reset, :on => :member
  end

  # Update a collection of permissions
  resources :permissions, :only => :update_multiple do
    put :update_multiple, :on => :collection
  end

  # Nested resources
  resources :folders, :shallow => true, :except => [:new, :create] do
    resources :folders, :only => [:new, :create]
    resources :files, :only => [:new, :create]
  end

  resources :files, :shallow => :true, :only => :show do
    resources :share_links, :only => [:new, :create]
  end


  # root 'view#route' 
  get '/md', to: 'view#route' # replaced root
  get '/readme', to: 'view#readme'
  get '/quiz', to: 'view#quiz'
  get '/file_exists', :to => 'files#exists'
  get '/signin', :to => 'sessions#new', :as => 'signin'
  delete '/signout', :to => 'sessions#destroy'

end
