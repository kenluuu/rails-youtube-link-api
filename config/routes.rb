Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  
  #youtube link routes
  post '/api/v1/links/create/', to: 'api/v1/youtube_links#create'
  get '/api/v1/links/', to: 'api/v1/youtube_links#index'

  #users routes
  post '/api/v1/users/signin/', to: 'api/v1/users#sign_in'
  post '/api/v1/users/create/', to: 'api/v1/users#create'
  get '/api/v1/users/link/', to: 'api/v1/users#get_links'
  get '/api/v1/users/show/:id/', to: 'api/v1/users#show'
  post '/api/v1/users/follow/', to: 'api/v1/users#follow'
  post '/api/v1/users/unfollow', to: 'api/v1/users#unfollow'
end
