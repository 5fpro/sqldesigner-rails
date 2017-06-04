# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :integer
#  uid        :string
#  auth_type  :string
#  auth_id    :integer
#  auth_data  :text
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authorization < ApplicationRecord
  enum provider: [:facebook, :github, :google_oauth2]

  validates :provider, :uid, :auth, presence: true
  validates :provider, uniqueness: { scope: :uid }
  belongs_to :auth, polymorphic: true
  serialize :auth_data, Hash
end
