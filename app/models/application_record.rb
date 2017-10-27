class ApplicationRecord < ActiveRecord::Base
  include ::Sortable
  include ::Restorable
  include ::Taggable
  include ::Omniauthable

  self.abstract_class = true
end
