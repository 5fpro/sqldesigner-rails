# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

class Category < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail only: [ :name, :deleted_at, :sort ]
  sortable column: :sort, add_new_at: nil

  validates_presence_of :name
  validates_uniqueness_of :name

end
