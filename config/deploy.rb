# config valid only for current version of Capistrano
lock '3.7.2'

set :application, 'myapp'
set :repo_url, 'git@github.com:5fpro/rails4-template.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
    # invoke 'unicorn:restart'

    # passenger
    # execute :mkdir, '-p', release_path.join('tmp')
    # execute :touch, release_path.join('tmp/restart.txt')
  end
end

# uncomment while first deploy
# before "deploy:migrate", "deploy:db_create"
# namespace :deploy do
#   task :db_create do
#     on primary fetch(:migration_role) do
#       within release_path do
#         with rails_env: fetch(:rails_env) do
#           execute :rake, "db:create"
#         end
#       end
#     end
#   end
# end

set :assets_roles, [:web, :worker, :assets_sync_server]
