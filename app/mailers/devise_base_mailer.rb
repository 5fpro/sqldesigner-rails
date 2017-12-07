class DeviseBaseMailer < Devise::Mailer
  include DeliverFilterConcern
end
