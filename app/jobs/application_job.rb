class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(*)
    raise '#perform method was not implemented yet'
  end
end
