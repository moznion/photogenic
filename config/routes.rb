Photogenic::Application.routes.draw do
  resources :contents

  root to: 'contents#new'
end
