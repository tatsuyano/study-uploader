# -*- coding: utf-8 -*-
Rails.application.routes.draw do
  resources :products
  root to: "home#index"
  get 'home/index'
  get 'home/show'

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"},
    controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
