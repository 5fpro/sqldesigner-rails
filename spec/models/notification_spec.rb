# == Schema Information
#
# Table name: notifications
#
#  id            :bigint(8)        not null, primary key
#  sender_type   :string
#  sender_id     :string
#  receiver_type :string
#  receiver_id   :string
#  object_type   :string
#  object_id     :string
#  notify_type   :string
#  readed        :boolean          default(FALSE)
#  subject       :string
#  body          :string
#  created_on    :date
#  data          :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Notification, type: :model do
  it do
    create(:notification)
  end
end
