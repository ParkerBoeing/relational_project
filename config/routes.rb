Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/crags', to: 'crags#index'
  get '/crags/:id', to: 'crags#show'
  get '/routes', to: 'routes#index'
  get '/routes/:id', to: 'routes#show'
  get '/crags/:crag_id/routes', to: 'crag_routes#index'
end
