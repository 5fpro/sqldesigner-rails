class StoreAssetJob < ApplicationJob
  include ::CarrierWave::Workers::StoreAssetMixin

  def when_not_ready
    retry_job
  end
end
