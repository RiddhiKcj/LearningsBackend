Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :todos
    end
  end

  root to: "home#index"
  
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy

  namespace :oauth do
    post 'gauth', controller: :googleauth, action: :create
  end
  
end
