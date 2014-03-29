Src::Application.routes.draw do
  root 'opportunity#find_all'
  get '/create/', to: 'opportunity#new'
  post '/create/', to: 'opportunity#create'
  delete '/delete/', to: 'opportunity#delete'
end
