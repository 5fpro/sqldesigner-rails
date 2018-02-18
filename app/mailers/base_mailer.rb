class BaseMailer < ApplicationMailer
  def notify
    mail(to: 'hi@5fpro.com')
  end
end
