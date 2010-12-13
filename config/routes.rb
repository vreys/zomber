Hdtv::Application.routes.draw do
  root :to => 'serials#index'

  devise_for :users, :controllers => { :invitations => 'users/invitations' }, :skip => [:sessions, :invitations]
  
  as :user do
    # Registration
    get 'signup/:invitation_token', :to => "users/invitations#edit",   :as => :accept_user_invitation
    put 'signup',                   :to => "users/invitations#update", :as => :user_invitation
    
    # Authentication
    post 'signin',  :to => "devise/sessions#create",  :as => :user_session
    get  'signin',  :to => "devise/sessions#new",     :as => :new_user_session
    get  'signout', :to => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :serials, :only => [:index, :show] do
    match ':season_index/:episode_index' => 'episodes#show', :as => :episode
  end

  match 'repos*path' => 'nowhere#imposible', :as => 'repository'
end
