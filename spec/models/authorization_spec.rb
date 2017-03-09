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

require 'rails_helper'

RSpec.describe Authorization, type: :model do
  it 'FactoryGirl' do
    expect(create(:authorization)).not_to be_new_record
  end
end
