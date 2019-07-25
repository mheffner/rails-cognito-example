Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  get '/sign_in', as: 'signin', to: 'sessions#signin'
  get '/sign_out', as: 'signout', to: 'sessions#signout'
  get '/sign_up', as: 'signup', to: 'sessions#signup'

  get 'auth/sign_in', to: 'auth#signin'
  get 'auth/sign_out', to: 'auth#signout'

  root to: 'home#index'
end
