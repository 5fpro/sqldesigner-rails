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
  acts_as_paranoid
  has_paper_trail

  validates_presence_of :name
  validates_uniqueness_of :name
end
