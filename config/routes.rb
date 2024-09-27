# frozen_string_literal: true

Rails.application.routes.draw do
  root 'prices#index'
  resources :prices, only: %i[index create]
  resources :items, only: %i[index show] do
    get 'search', on: :collection
  end
end
