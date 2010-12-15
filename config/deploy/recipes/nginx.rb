Capistrano::Configuration.instance(:must_exist).load do
  # Path to the nginx erb template to be parsed before uploading to remote
  set :nginx_local_config do
    Rails.root.join("config", "deploy", "generators", "nginx.conf.erb")
  end unless exists?(:nginx_local_config)

  # Path to where your remote config will reside (I use a directory sites inside conf)
  set(:nginx_remote_config) do
    File.join(shared_path, "config", "#{application}.conf")
  end unless exists?(:nginx_remote_config)

  namespace :nginx do
    desc "Parses and uploads nginx configuration for this app."
    task :setup, :roles => :app, :except => { :no_release => true } do
      generate_config(nginx_local_config, nginx_remote_config)
    end
  end

  # after 'deploy:setup' do
  #   nginx.setup if Capistrano::CLI.ui.agree("Create nginx configuration file? [Yn]")
  # end
end
