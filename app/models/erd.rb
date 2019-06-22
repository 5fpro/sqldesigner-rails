# == Schema Information
#
# Table name: erds
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  is_published :boolean          default(TRUE)
#  keyword      :string
#  data         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Erd < ApplicationRecord

  validates :keyword, uniqueness: { uniqueness: { scope: [:user_id] }, presence: true }
  belongs_to :user

  include ActsAsVersioning
  acts_as_versioning only: [:data]

  def published?
    is_published
  end

end
