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

class Admin::Category < ::Category

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:delete_state, :tagged]
    end
  end
end
