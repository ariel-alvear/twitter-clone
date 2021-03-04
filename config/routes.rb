Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :tweets do
    end
    resources :likes
  end
  
  get '/tweets/retweet/:id', to: 'tweets#retweet', as: 'retweet'

  devise_for :users
  
  resources :users do
    resources :friends
  end

  get '/:hashtag', to: 'tweets#hashtag_search', as: 'hashtag'

  get '/api/news', to: 'api#index'
  get "/api/:date1/:date2", to: 'api#between_dates'
  post '/api/create', to: 'api#create'
  

  root to: 'tweets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
