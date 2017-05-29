# more config options:
#   https://github.com/seuros/capistrano-sidekiq/blob/master/lib/capistrano/tasks/sidekiq.cap

namespace :load do
  task :defaults do
    set :sidekiq_role, -> { :worker }
    set :sidekiq_default_hooks, -> { false }
    # set :sidekiq_pid,           -> { File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') }
    # set :sidekiq_env,           -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
    # set :sidekiq_log,           -> { File.join(shared_path, 'log', 'sidekiq.log') }
    # set :sidekiq_timeout,       -> { 10 }
    # set :sidekiq_processes,     -> { 1 }
  end
end

namespace :sidekiq do
  task :restart do
    invoke 'sidekiq:stop'
    # invoke 'sidekiq:start'
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:updated', 'sidekiq:stop'
after 'deploy:reverted', 'sidekiq:stop'
after 'deploy:published', 'sidekiq:stop'
# monit will auto start it
# after 'deploy:published', 'sidekiq:start'
