Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:create] do
    get :feeds, on: :collection
    get :user_tweets, on: :collection
  end

  resources :follows, only: [] do
    put :follow, on: :collection
    put :unfollow, on: :collection
  end

  resources :users, only: [:show]
end
