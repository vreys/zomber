# -*- coding: utf-8 -*-
require 'config/deploy/helpers'
require 'config/deploy/recipes/nginx'
require 'config/deploy/recipes/unicorn'
require 'config/deploy/recipes/symlinks'
require 'config/deploy/recipes/hooks'

set :application, "zomber"

##################################################
## Конфиг сервера
##################################################
set :domain, "91.213.233.101"

server domain, :app, :web

role :app, domain
role :web, domain
role :db, domain, :primary => true

##################################################
## Удаленный доступ
##################################################
set :user, "zomber"
set :group, "dev"
set :use_sudo, false

default_run_options[:pty] = false

##################################################
## Приложение
##################################################
set :deploy_to, "/home/#{user}/apps/#{application}"
set :keep_releases, 3

set :rails_env, "production"

set :application_port, 80

set :shared_dirs, %w( config bundle tmp run pids db posters thumbnails repos )

set :sockets_path, "#{shared_path}/run"
set :pids_path, "#{shared_path}/pids"

set :unicorn_socket, File.join(sockets_path,'unicorn.sock')

namespace :app do
  task :setup, :roles => :app do
    commands = shared_dirs.map do |path|
      "if [ ! -d '#{path}' ]; then mkdir -p #{path}; fi;"
    end
    run "cd #{shared_path}; #{commands.join(' ')}"
  end
end

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    unicorn.start
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    unicorn.stop
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    unicorn.restart
  end
end

default_environment["HTTP_PROXY"] = "http://numberone.kg:1234"
default_environment["GEM_HOME"] = "$HOME/.gem"
default_environment["PATH"] = "$PATH:$HOME/.gem/bin:#{shared_path}/bundle/ruby/1.8/bin"

##################################################
## Репозиторий кода
##################################################
set :scm, :git
set :repository, "zomber@91.213.233.101:zomber.git"
set :branch, "master"

set :git_shallow_clone, 1
set :deploy_via, :remote_cache

set :scm_verbose, true
