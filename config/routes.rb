# -*- coding: utf-8 -*-
Rails.application.routes.draw do
  get  '/products/',    to: 'products#index'
  get  '/products/new', to: 'products#new'
  get  '/products/:id', to: 'products#destroy'
  post '/products/',    to: 'products#create'  

  root to: "home#index"
  get 'home/index'
  get 'home/show'

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"},
    controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
