Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get "/home/about" =>"homes#about"


  resources :users, only: [:show, :index, :edit, :update] do
     resource :relationships, only: [:create, :destroy]
  end

  get 'followed' => 'relationships#followed'
  get 'followers' => 'relationships#follower'


  resources :books
end