Rails.application.routes.draw do
	
  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact
  
   
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :index]
  get 'profile', to: 'users#profile', as: :profile

  get 'complete/:id', to: 'tasks#complete', as: :complete

  resources :projects do
    resources :tasks, except: [:index, :show]
  end 
end
