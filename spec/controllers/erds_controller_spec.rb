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

RSpec.describe ErdsController, type: :controller do

end
