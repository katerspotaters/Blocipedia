Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  
  resources :charges, only: [:new, :create]

  devise_for :users
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  get "profile" => "users#show", :as => 'profile'
  post "users/downgrade" => 'users#downgrade', :as => 'downgrade_user'
end
