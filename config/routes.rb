# frozen_string_literal: true

Rails.application.routes.draw do
  root 'prices#index'
  resources :prices, only: %i[new create]
  resources :items, only: %i[index show new create]
end
