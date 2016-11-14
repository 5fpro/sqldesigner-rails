namespace :load do
  task :defaults do
    set :rollbar_token, ''
    set :rollbar_env, proc { fetch :stage }
    set :rollbar_role, proc { :db }
  end
end
