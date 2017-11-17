namespace :dev do

  desc 'Rebuild from schema.rb'
  task build: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:schema:load', 'dev:fake']

  desc 'Rebuild from migrations'
  task rebuild: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'generate fake data for development'
  task fake: :environment do
    email = 'admin@5fpro.com'
    User.find_by(email: email) || FactoryBot.create(:user, email: email, password: '12341234', admin: true)
  end

end
