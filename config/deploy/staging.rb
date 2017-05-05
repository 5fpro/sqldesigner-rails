set :deploy_to, "/home/apps/#{fetch(:application)}"
set :rails_env, 'production'
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}
# Config@initial
server = 'myapp.5fpro.com'
role :app,                server
role :web,                server
role :db,                 server
role :worker,             server
role :assets_sync_server, server
