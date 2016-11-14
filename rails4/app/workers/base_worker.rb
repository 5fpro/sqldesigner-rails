class BaseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # To see usage of sidetiq:
  #   https://github.com/tobiassvn/sidetiq/wiki/Basic-Usage
  # recurrence { daily }
  # def perform
  # end
end
