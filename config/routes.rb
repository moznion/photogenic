Photogenic::Application.routes.draw do
  resources :contents

  get "home/index"

  root to: 'home#index'
end
