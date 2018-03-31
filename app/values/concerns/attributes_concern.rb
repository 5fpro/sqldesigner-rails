module AttributesConcern
  extend ActiveSupport::Concern

  included do
    include ActiveModel::AttributeAssignment
  end

  module ClassMethods
    def attr_accessor(*args)
      merge_attributes!(args)
      super(*args)
    end

    def attr_reader(*args)
      merge_attributes!(args)
      super(*args)
    end

    def attributes
      @_attributes ||= []
      @_attributes.map(&:to_sym)
    end

    private

    def merge_attributes!(args)
      @_attributes ||= []
      @_attributes += args
      @_attributes.uniq!
    end
  end

  def initialize(attrs = {})
    assign_attributes(attrs || {})
  end

  def attributes
    self.class.attributes.inject({}) do |a, e|
      a.merge(e => public_send(e))
    end.with_indifferent_access
  end
end
