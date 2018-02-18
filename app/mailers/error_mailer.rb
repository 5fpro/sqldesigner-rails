class ErrorMailer < BaseMailer
  default to: ENV['ERROR_MAILER_TO']
  def notify(error)
    @error = error
    mail(subject: { klass: @error.class.to_s, message: @error.message })
  end
end
