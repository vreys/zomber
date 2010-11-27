Hdtv::Application.routes.draw do
  root :to => 'serials#index'

  resources :serials, :only => [:index, :show]
end
