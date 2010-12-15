Capistrano::Configuration.instance(:must_exist).load do
  namespace :nginx do
    def nginx_cmd(opts = '')
      "#{nginx_bin} #{opts}"
    end
    
    def nginx_signal_cmd(signal)
      nginx_cmd("-s #{signal}")
    end
    
    def nginx_stop_cmd
      nginx_signal_cmd('stop')
    end

    def nginx_reload_cmd
      nginx_signal_cmd('reload')
    end

    def nginx_quit_cmd
      nginx_signal_cmd('quit')
    end

    def nginx_start_cmd
      nginx_cmd
    end
  
    desc "Restart nginx"
    task :restart, :roles => :app , :except => { :no_release => true } do
      sudo nginx_stop_cmd
      sudo nginx_start_cmd
    end
    
    desc "Stop nginx"
    task :stop, :roles => :app , :except => { :no_release => true } do
      sudo nginx_stop_cmd
    end
    
    desc "Start nginx"
    task :start, :roles => :app , :except => { :no_release => true } do
      sudo nginx_start_cmd
    end

    desc "Reload nginx config (without restarting)"
    task :reload, :roles => :app , :except => { :no_release => true } do
      sudo nginx_reload_cmd
    end

    desc "Quit nginx"
    task :quit, :roles => :app , :except => { :no_release => true } do
      sudo nginx_quit_cmd
    end

    desc "Test configuration syntax"
    task :test_config, :roles => :app , :except => { :no_release => true } do
      sudo nginx_cmd("-t")
    end
  end
end
