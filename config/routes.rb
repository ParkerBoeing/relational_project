Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/crags', to: 'crags#index'
  get '/crags/new', to: 'crags#new'
  get '/crags/:id', to: 'crags#show'
  get '/routes', to: 'routes#index'
  get '/routes/:id', to: 'routes#show'
  get '/crags/:crag_id/routes', to: 'crag_routes#index'
  post '/crags', to: 'crags#create'
  get "/crags/:id/edit", to: "crags#edit"
  patch "/crags/:id", to: "crags#update"
  get '/crags/:crag_id/routes/new', to: 'crag_routes#new'
  post '/crags/:crag_id/routes', to: 'crag_routes#create'
  get "/routes/:id/edit", to: "routes#edit"
  patch "/routes/:id", to: "routes#update"
  delete "/crags/:id", to: "crags#destroy"
end
