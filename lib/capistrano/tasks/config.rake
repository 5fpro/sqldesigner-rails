CAP_CONFIG_FILES = [
  '.env',
  'config/application.yml'
].freeze

namespace :config do

  def to_staged_file(file)
    file.index('.yml') ? file.gsub('.yml', ".#{fetch(:stage)}.yml") : "#{file}.#{fetch(:stage)}"
  end

  task :upload do
    on roles(:all) do |_host|
      CAP_CONFIG_FILES.each do |file|
        staged_file = to_staged_file(file)
        upload!("./#{staged_file}", "#{shared_path}/#{file}")
      end
    end
  end

  task :download do
    on roles(:all) do |_host|
      CAP_CONFIG_FILES.each do |file|
        staged_file = to_staged_file(file)
        download!("#{shared_path}/#{file}", "./#{staged_file}")
      end
    end
  end
end
