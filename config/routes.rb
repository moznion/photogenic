Photogenic::Application.routes.draw do
  resources :contents, only: ['new', 'create', 'show']

  get '/:id(.:format)', to: 'contents#show'

  root to: 'contents#new'
end
