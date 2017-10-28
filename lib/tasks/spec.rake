if Rails.env.development? || Rails.env.test?
  namespace :spec do

    RSpec::Core::RakeTask.new(:features) do |task|
      file_list = FileList['spec/**/*.feature']
      task.pattern = file_list
    end
  end
end
