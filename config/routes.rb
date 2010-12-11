Hdtv::Application.routes.draw do
  devise_for :users, :controllers => { :invitations => "users/invitations" }

  root :to => 'serials#index'

  resources :serials, :only => [:index, :show] do
    match ':season_index/:episode_index' => 'episodes#show', :as => :episode
  end

  match 'repos*path' => 'nowhere#imposible', :as => 'repository'
end
