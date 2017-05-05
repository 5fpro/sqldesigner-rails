require 'dotenv'
Dotenv.load

# see more
#   https://github.com/tablexi/capistrano3-unicorn/blob/master/examples/unicorn.rb
app_path = "/home/apps/#{ENV['APP_NAME']}"
working_directory "#{app_path}/current"
pid "#{app_path}/current/tmp/pids/unicorn.pid"
listen "/tmp/unicorn.#{ENV['APP_NAME']}.sock"

# log rotate config example
#   https://github.com/defunkt/unicorn/blob/master/examples/logrotate.conf
stderr_path 'log/unicorn.error.log'
stdout_path 'log/unicorn.log'

worker_processes 1

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

rails_env = ENV['RAILS_ENV'] || 'production'

preload_app true

GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true


before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
  Redis.current.client.reconnect
end
