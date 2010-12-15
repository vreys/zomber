Capistrano::Configuration.instance(:must_exist).load do
  # Number of workers (Rule of thumb is 2 per CPU)
  # Just be aware that every worker needs to cache all classes and thus eat some
  # of your RAM. 
  set :unicorn_workers, 4 unless exists?(:unicorn_workers)

  # Workers timeout in the amount of seconds below, when the master kills it and
  # forks another one.
  set :unicorn_workers_timeout, 30 unless exists?(:unicorn_workers_timeout)

  # Workers are started with this user/group
  # By default we get the user/group set in capistrano.
  set(:unicorn_user) { user }   unless exists?(:unicorn_user)
  set(:unicorn_group) { group } unless exists?(:unicorn_group)

  # The wrapped bin to start unicorn
  # This is necessary if you're using rvm
  set :unicorn_bin, 'bundle exec unicorn_rails' unless exists?(:unicorn_bin)

  set :unicorn_socket do
    File.join(sockets_path,'unicorn.sock')
  end unless exists?(:unicorn_socket)

  # Defines where the unicorn pid will live.
  set(:unicorn_pid) do
    File.join(pids_path, "unicorn.pid")
  end unless exists?(:unicorn_pid)

  # Our unicorn template to be parsed by erb
  # You may need to generate this file the first time with the generator
  # included in the gem
  set(:unicorn_local_config) do
    Rails.root.join("config", "deploy", "generators", "unicorn.rb.erb")
  end

  # The remote location of unicorn's config file. Used by god to fire it up
  set(:unicorn_remote_config) { "#{shared_path}/config/unicorn.rb" }

  def unicorn_start_cmd
    "cd #{current_path} && #{unicorn_bin} -c #{unicorn_remote_config} -E #{rails_env} -D"
  end
  
  def unicorn_stop_cmd
    "kill -QUIT `cat #{unicorn_pid}`"
  end
  
  def unicorn_restart_cmd
    "kill -USR2 `cat #{unicorn_pid}`"
  end

  # Unicorn 
  #------------------------------------------------------------------------------
  namespace :unicorn do    
    desc "Starts unicorn directly"    
    task :start, :roles => :app do
      run unicorn_start_cmd
    end  
    
    desc "Stops unicorn directly"    
    task :stop, :roles => :app do
      run unicorn_stop_cmd
    end  
    
    desc "Restarts unicorn directly"    
    task :restart, :roles => :app do
      run unicorn_restart_cmd
    end
    
    desc <<-EOF
    Parses the configuration file through ERB to fetch our variables and \
    uploads the result to unicorn remote config, to be loaded by whoever is \
    booting up the unicorn.
    EOF
    task :setup, :roles => :app , :except => { :no_release => true } do
      run "mkdir -p #{sockets_path}" 
      run "chown -R #{user}:#{group} #{sockets_path}"
      generate_config(unicorn_local_config, unicorn_remote_config)
    end
  end
  
  after 'deploy:setup' do
    unicorn.setup if Capistrano::CLI.ui.agree("Create unicorn configuration file? [Yn]")
  end
end
