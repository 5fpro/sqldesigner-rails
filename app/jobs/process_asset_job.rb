class ProcessAssetJob < ApplicationJob
  include ::CarrierWave::Workers::ProcessAssetMixin

  def when_not_ready
    retry_job
  end
end
