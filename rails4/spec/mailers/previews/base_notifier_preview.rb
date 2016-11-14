# Preview all emails at http://localhost:3000/rails/mailers/base_notifier
class BaseNotifierPreview < ActionMailer::Preview
  def notify
    BaseNotifier.notify
  end
end
