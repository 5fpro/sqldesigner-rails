# more config options:
#   https://github.com/tablexi/capistrano3-unicorn/blob/master/lib/capistrano3/tasks/unicorn.rake

namespace :load do
  task :defaults do
    set :unicorn_roles, -> { :web }
    # set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
    # set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn", "#{fetch(:rails_env)}.rb") }
    # set :unicorn_options, -> { "" }
    # set :unicorn_rack_env, -> { fetch(:rails_env) == "development" ? "development" : "deployment" }
    # set :unicorn_restart_sleep_time, 3
  end
end
