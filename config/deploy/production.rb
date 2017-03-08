set :deploy_to, '/home/apps/myapp'
set :rails_env, 'production'
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}

require 'aws-sdk-v1'
require 'aws-sdk'
aws_conf = YAML.load(IO.read('./config/application.yml'))['development']['aws'].symbolize_keys
AWS.config(aws_conf)
lb_name = 'lb.5fpro.com'
servers = AWS::ELB.new.load_balancers[lb_name].instances.map(&:ip_address)

shadow_server = 'myapp.5fpro.com'
role :app,                servers
role :web,                servers
role :db,                 shadow_server
role :worker,             shadow_server
role :assets_sync_server, shadow_server
