module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    # to see options:
    #   https://github.com/swanandp/acts_as_list
    def sortable(opts = {})
      column = opts[:column] || "position" # acts as list default

      acts_as_list(opts)
      scope :sorted, ->{ where.not(column => nil).where("#{column} ASC") }
    end
  end
end
