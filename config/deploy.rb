# -*- encoding : utf-8 -*-
# default_environment["PATH"] = "/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin"

begin
  require 'capistrano_colors'
rescue LoadError
  puts "`gem install capistrano_colors` to get output more userfriendly."
end

require "rvm/capistrano"
set :rvm_type, :system

require 'capistrano/ext/multistage'
set :stages,        %w(production)
set :default_stage, "production"

require 'bundler/capistrano'

set :scm, :git

# set :deploy_via, :remote_cache
set :git_shallow_clone, 1

set :scm_verbose, true
set :use_sudo, false


namespace :deploy do

  desc "Restart passenger process"
  task :restart, :roles => [:web], :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


namespace :my_tasks do
  task :symlink, :roles => [:web] do
    run "mkdir -p #{deploy_to}/shared/log"
    run "mkdir -p #{deploy_to}/shared/pids"
    
    symlink_hash = {
      "#{shared_path}/config/database.yml"   => "#{release_path}/config/database.yml",
      "#{shared_path}/config/config.yml"   => "#{release_path}/config/config.yml",
      "#{shared_path}/uploads"              => "#{release_path}/public/uploads",
    }

    symlink_hash.each do |source, target|
      run "ln -sf #{source} #{target}"
    end
  end

end



namespace :remote_rake do
  desc "Run a task on remote servers, ex: cap staging rake:invoke task=cache:clear"
  task :invoke do
    run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bundle exec rake #{ENV['task']}"
  end
end

after "deploy:finalize_update", "my_tasks:symlink"


require 'puma/capistrano'