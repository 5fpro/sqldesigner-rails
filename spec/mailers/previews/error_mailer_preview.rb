# Preview all emails at http://localhost:3000/rails/mailers/error_mailer
class ErrorMailerPreview < ActionMailer::Preview
  def notify
    error = ApplicationError.new(message: 'ha')
    ErrorMailer.notify(error)
  end
end
