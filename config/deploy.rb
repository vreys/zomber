# -*- coding: utf-8 -*-
require 'config/deploy/helpers'
require 'config/deploy/recipes/nginx'

default_environment["HTTP_PROXY"] = "http://numberone.kg:1234"
default_environment["GEM_HOME"] = "$HOME/.gem"
default_environment["PATH"] = "$PATH:$HOME/.gem/bin"

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

##################################################
## Приложение
##################################################
set :deploy_to, "/home/#{user}/apps/#{application}"
set :keep_releases, 3

set :rails_env, "production"

set :application_port, 80

set :sockets_path, "#{shared_path}/run"
set :pids_path, "#{shared_path}/pids"

set :unicorn_socket, File.join(sockets_path,'unicorn.sock') unless exists?(:unicorn_socket)

# set :app_server, :unicorn
# set :web_server, :nginx

# set :application_port, 80
# set :application_uses_ssl, false

# set :database, :sqlite

# #set :using_rvm, false

# set :shared_children, shared_children + ['run']

# set :sockets_path, "#{shared_path}/run"
# set :pids_path, "#{shared_path}/pids"

# ##################################################
# ## Репозиторий кода
# ##################################################
# set :scm, :git
# set :repository, "zomber@91.213.233.101:zomber.git"
# set :branch, "master"

# set :git_shallow_clone, 1
# set :deploy_via, :remote_cache

# set :scm_verbose, true

# ##################################################
# ## Nginx
# ##################################################
# set :nginx_bin, "/usr/local/sbin/nginx"
# set :nginx_path_prefix, "/usr/local/nginx"

# # Шаблон конфига (ERB)
# set :nginx_local_config, File.join("config", "nginx.conf.erb")

# # Куда класть конфиг на удаленном сервере
# set :nginx_remote_config, File.join(shared_path, "config", "#{application}.nginx.conf")

# ##################################################
# ## Unicorn
# ##################################################
# set :unicorn_workers, 2
# set :unicorn_workers_timeout, 30

# set :unicorn_user, user
# set :unicorn_group, group

# # Шаблон конфига (ERB)
# set :unicorn_local_config, File.join("config", "unicorn.rb.erb")

# # Конфиг на удаленном сервере
# set :unicorn_remote_config, File.join(shared_path, "config", "unicorn.rb")

# #require 'capistrano_recipes'
# #require 'config/deploy/nginx'

# default_run_options[:pty] = false
# #ssh_options[:forward_agent] = false
