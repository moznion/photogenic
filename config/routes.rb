Photogenic::Application.routes.draw do
  resources :contents, only: ['create', 'show']

  root to: 'contents#new'
end
