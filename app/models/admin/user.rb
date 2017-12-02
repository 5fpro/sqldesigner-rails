# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#

class Admin::User < ::User

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:has_avatar]
    end

    def has_avatar(_boolean = true)
      where.not(avatar: nil)
    end

    def to_csv(opts = {})
      CSV.generate(opts) do |csv|
        csv << ['ID', 'Name', 'Email']
        offset(0).limit(relation.count).all.find_each do |o| # reset pagination
          csv << [o.id, o.name, o.email]
        end
      end
    end
  end

end
