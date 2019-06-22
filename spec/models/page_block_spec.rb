# == Schema Information
#
# Table name: page_blocks
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  body       :text
#  enabled    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PageBlock, type: :model do
  it do
    create(:page_block)
  end
end
