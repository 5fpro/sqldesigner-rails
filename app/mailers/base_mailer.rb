class BaseMailer < ApplicationMailer
  def notify
    mail(to: 'hi@5fpro.com', subject: 'Hello!')
  end
end
