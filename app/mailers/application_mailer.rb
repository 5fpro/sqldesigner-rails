class ApplicationMailer < ActionMailer::Base
  include DeliverFilterConcern
  default from: Setting.mailer.default_sender
  add_template_helper MailerHelper
  layout 'mailer'
end
