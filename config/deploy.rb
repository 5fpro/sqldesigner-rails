# config valid only for Capistrano 3.1
lock '3.6.1'

set :application, 'gh-musou'
set :repo_url, 'git@github.com:5fpro/sqldesigner-rails.git'
set :deploy_to, '/home/apps/sqldesigner-rails'
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}

set :default_env, {
  'EXECJS_RUNTIME' => 'Node'
}
# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/config.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end

set :rvm_ruby_version, File.read('.ruby-version').strip
