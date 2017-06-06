namespace :load do
  task :defaults do
    set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
    set :rollbar_env, proc { fetch :stage }
    set :rollbar_role, proc { :db }
  end
end
