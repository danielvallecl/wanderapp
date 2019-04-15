Rails.application.routes.draw do

  resources :actives
  resources :preferences
  resources :users, except: [:new]
  resources :events

  get 'signup', to: 'users#new'

  # Event Routes

  # Login Routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # About routes
  get 'about', to:'pages#about'

  # Root Route - # The subdirectories of root don't need a directory/reference

  root 'pages#home'

end
