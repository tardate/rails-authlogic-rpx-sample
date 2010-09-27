RailsAuthlogicRpxSample::Application.routes.draw do
  resources :user_sessions
  resources :users
  resources :articles do
      resources :comments
  end
  root :to => 'articles#index' 
  match 'signin' => 'user_sessions#new', :as => :signin
  match 'signout' => 'user_sessions#destroy', :as => :signout
  match 'addrpxauth' => 'users#addrpxauth', :as => :addrpxauth, :method => :post
end
