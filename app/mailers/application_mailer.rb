class ApplicationMailer < ActionMailer::Base
  default from: Setting.mailer.default_sender
  add_template_helper MailerHelper
  layout 'mailer'
end
