# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

class Category < ApplicationRecord
  has_paper_trail only: [:name, :deleted_at, :sort]
  sortable column: :sort, add_new_at: nil
  restorable
  taggable

  validates :name, presence: true, uniqueness: true

end
