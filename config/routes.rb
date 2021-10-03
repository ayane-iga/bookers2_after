Rails.application.routes.draw do

  get "home/about" => "homes#show"
  root to: 'homes#index'
  devise_for :users
<<<<<<< HEAD
  resources :users, only:[:show, :edit, :update, :index] do
    get 'following' => 'relationships#following'
    get 'followed' => 'relationships#followed'
  end



  resources :books do
  	resource :favorites, only:[:create, :destroy]
  	resources :book_comments, only:[:create, :destroy]
  end

  resources :relationships, only:[:create, :destroy]

  get '/search' => 'searches#search'
=======
  resources :books
  resources :users, only:[:show, :edit, :update, :index]
>>>>>>> origin/master
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
