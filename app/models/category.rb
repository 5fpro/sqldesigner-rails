# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  acts_as_paranoid
end
