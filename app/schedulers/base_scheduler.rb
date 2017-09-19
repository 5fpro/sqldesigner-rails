require 'sidekiq-scheduler'

class BaseScheduler
  include Sidekiq::Worker

  def perform
    raise NotImplementedError, 'perform'
  end
end
