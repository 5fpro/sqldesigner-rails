module Taggable
  extend ActiveSupport::Concern

  module ClassMethods
    # to see options:
    #   https://github.com/mbleigh/acts-as-taggable-on
    def taggable(*opts)
      acts_as_taggable(*opts)
      define_class_methods_for_taggable!
    end

    private

    def define_class_methods_for_taggable!
      self.class.instance_eval do
        define_method :tagged, lambda { |*tags|
          tags.select!(&:present?)
          !tags.empty? ? tagged_with(tags, any: true) : where(nil)
        }
      end
    end
  end

end
