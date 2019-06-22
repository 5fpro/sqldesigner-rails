set :deploy_to, "/home/apps/#{fetch(:application)}"
set :rails_env, 'production'
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}

servers = ['sql.5fpro.com']

shadow_server = 'sql.5fpro.com'
role :app,                servers
role :web,                servers + [shadow_server]
role :db,                 shadow_server
role :worker,             shadow_server
role :assets_sync_server, shadow_server
