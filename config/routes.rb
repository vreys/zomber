Hdtv::Application.routes.draw do
  constraints :subdomain => 'repo', :format => /(mp4|webm)/, :season_index => /(\d+)/, :episode_index => /(\d+)/ do
    match ':serial_slug/:season_index/:episode_index.:format' => 'repository#send_video', :as => :repo
  end
  
  root :to => 'serials#index'

  scope :module => "users" do
    devise_for :users, :controllers => { :invitations => 'invitations' }, :skip => [:sessions, :invitations]
    
    as :user do
      # Registration
      get 'signup/:invitation_token', :to => "invitations#edit",   :as => :accept_user_invitation
      put 'signup',                   :to => "invitations#update", :as => :user_invitation
      
      # Authentication
      post 'signin',  :to => "sessions#create",  :as => :user_session
      get  'signin',  :to => "sessions#new",     :as => :new_user_session
      get  'signout', :to => "sessions#destroy", :as => :destroy_user_session
    end
  end

  resources :serials, :only => [:index, :show] do
    match ':season_index/:episode_index' => 'episodes#show', :as => :episode
  end

  match 'repos*path' => 'nowhere#imposible', :as => 'repository'
end
