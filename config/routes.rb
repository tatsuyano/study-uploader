Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  get 'home/show'

  root to: "home#index"
end
