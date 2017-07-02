Rails.application.routes.draw do

  # TODO - Delete this
  post "tmp/create_iteration" => "tmp#create_iteration", as: :tmp_create_iteration

  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :api do
    resources :tracks, only: [] do
      resources :exercises, only: [] do
        resource :solution, only: [:show]
      end
    end
  end

  resources :tracks, only: [:index, :show]
  resources :user_tracks, only: [:create]
  resources :solutions, only: [:show] do
    member do
      get :confirm_unapproved_completion
      patch :complete
      get :reflection
      patch :reflect
    end
  end

  resources :discussion_posts, only: [:create]
  resources :notifications, only: [:index]

  namespace :admin do
    resource :dashboard, only: [:show], controller: "dashboard"
  end

  namespace :mentor do
    resource :dashboard, only: [:show], controller: "dashboard"
  end

  post "markdown/parse" => "markdown#parse"

  %w{
  donate
  }.each do |page|
    get page => "pages##{page}", as: "#{page}_page"
  end
  root to: "pages#index"
end
