# Preview all emails at http://localhost:3000/rails/mailers/base_mailer
class BaseMailerPreview < ActionMailer::Preview
  def notify
    BaseMailer.notify
  end
end
