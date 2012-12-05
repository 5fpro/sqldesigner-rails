class Erd < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :keyword, :scope => [:user_id]
  validates_presence_of :keyword
  validates_presence_of :user_id
  belongs_to :user
end
