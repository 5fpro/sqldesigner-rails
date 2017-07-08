class BaseNotifier < ApplicationMailer
  def notify
    mail(to: 'hi@5fpro.com', subject: format_subject('Hello!'))
  end

  protected

  def format_subject(str)
    Rails.env.production? || Rails.env.test? ? str : "[#{Rails.env}] #{str}"
  end
end
