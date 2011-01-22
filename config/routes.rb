Hdtv::Application.routes.draw do
  constraints :subdomain => 'repo', :format => /(mp4|webm)/, :season_index => /(\d+)/, :episode_index => /(\d+)/ do
    match ':serial_slug/:season_index/:episode_index.:format' => 'repository#send_video', :as => :repo
  end
  
  root :to => 'serials#index'

  match "/feedback" => "feedback#index", :as => 'feedback'

  scope :module => "users" do
    devise_for :users,
    :controllers => {
      :invitations => 'invitations',
      :passwords   => 'passwords' },
    :skip => [:sessions, :invitations, :passwords]
    
    as :user do
      # Registration
      get 'signup/:invitation_token', :to => "invitations#edit",   :as => :accept_user_invitation
      put 'signup',                   :to => "invitations#update", :as => :user_invitation
      
      # Authentication
      post 'signin',  :to => "sessions#create",  :as => :user_session
      get  'signin',  :to => "sessions#new",     :as => :new_user_session
      get  'signout', :to => "sessions#destroy", :as => :destroy_user_session

      # Reset password
      get  'password',                       :to => "passwords#new",    :as => :new_user_password
      get  'password/:reset_password_token', :to => "passwords#edit",   :as => :edit_user_password
      post 'password',                       :to => 'passwords#create', :as => :user_password
      put  'password',                       :to => 'passwords#update'
    end
  end

  resources :serials do
    resources :seasons do
      put "down", :on => :member
      put "up", :on => :member

      resources :episodes
    end
  end

  match 'repos*path' => 'nowhere#imposible', :as => 'repository'
end
