module Omniauthable
  extend ActiveSupport::Concern

  module ClassMethods
    def omniauthable(opts = {})
      has_many :authorizations, opts.merge(dependent: :destroy, as: :auth)
    end
  end

  def confirmable?
    respond_to?(:confirmed?)
  end
end
