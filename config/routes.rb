require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do

  constraints Monban::Constraints::SignedIn.new do
    root "dashboards#show", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new"
  end

  resources :images do
    resources :textcomments, only: [:create]
    resources :picturecomments, only: [:create]
  end

  resources :comments, only: [:create]
  resource :session, only: [:new, :create, :destroy]
  resources :locations, only: [:new, :index, :show, :create]
  resources :users, except: [:destroy]
end
