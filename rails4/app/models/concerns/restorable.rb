module Restorable
  extend ActiveSupport::Concern

  module ClassMethods
    # to see options:
    #   https://github.com/radar/paranoia
    def restorable(opts = {})
      acts_as_paranoid(opts)
      define_class_methods_for_restore!
    end

    private

    def define_class_methods_for_restore!
      self.class.instance_eval do
        define_method :delete_state, lambda { |value|
          if [:only_deleted, :with_deleted].include?(value.to_sym)
            public_send(value)
          else
            where(nil)
          end
        }

      end
      send :define_method, :restorable?, -> { true }
    end
  end

  def restorable?
    false
  end
end
