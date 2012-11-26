class Erd < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :keyword
  validates_presence_of :keyword
end
