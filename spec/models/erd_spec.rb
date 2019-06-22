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

require 'rails_helper'

RSpec.describe Erd, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
