Photogenic::Application.routes.draw do
  resources :contents, only: ['new', 'create', 'show']

  root to: 'contents#new'
end
