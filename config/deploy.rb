# config valid only for current version of Capistrano
lock '3.10.1'

# Config@initial
set :application, ENV.fetch('APP_NAME') { '5FPRO' }
set :repo_url, 'git@github.com:5fpro/rails-template.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_map_bins, %w{rake gem bundle ruby rails unicorn sidekiq sidekiqctl}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :config_files, [
  '.env',
  'config/application.yml'
]

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(*fetch(:config_files))

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
set :default_env, {
  'EXECJS_RUNTIME' => 'Node'
}

# Default value for keep_releases is 5
# set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
after 'deploy:published', 'bundler:clean'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

# capistrano-rails => https://github.com/capistrano/rails/blob/master/lib/capistrano/tasks/assets.rake
set :assets_roles, [:web, :worker, :assets_sync_server]
