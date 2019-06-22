# == Schema Information
#
# Table name: activities
#
#  id          :bigint(8)        not null, primary key
#  actor_type  :string
#  actor_id    :integer
#  action      :string
#  target_type :string
#  target_id   :integer
#  acted_on    :date
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it do
    create(:activity)
  end
end
