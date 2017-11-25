class ErrorMailer < BaseMailer
  default to: ENV['ERROR_MAILER_TO']
  def notify(error)
    @error = error
    mail(subject: format_subject("Critical Error! #{@error.class}: #{@error.message}"))
  end
end
