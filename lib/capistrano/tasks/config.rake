namespace :config do
  task :upload_dotenv do
    on roles(:all) do |_host|
      upload!("./.env.#{fetch(:stage)}", "#{shared_path}/.env")
    end
  end

  task :download_dotenv do
    on roles(:all) do |_host|
      download!("#{shared_path}/.env", "./.env.#{fetch(:stage)}")
    end
  end

  task :upload_yml do
    on roles(:all) do |_host|
      upload!("./config/application.#{fetch(:stage)}.yml", "#{shared_path}/config/application.yml")
    end
  end

  task :download_yml do
    on roles(:all) do |_host|
      download!("#{shared_path}/config/application.yml", "./config/application.#{fetch(:stage)}.yml")
    end
  end
end
