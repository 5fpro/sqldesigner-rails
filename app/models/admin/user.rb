# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#

class Admin::User < ::User

  class << self
    def ransackable_scopes(auth_object = nil)
      [ :has_avatar ]
    end

    def has_avatar(boolean = true)
      where.not(avatar: nil)
    end

    def to_csv(opts = {})
      CSV.generate(opts) do |csv|
        csv << ["ID", "Name", "Email"]
        offset(0).limit(relation.count).all.each do |o| # reset pagination
          csv << [o.id, o.name, o.email]
        end
      end
    end
  end

end
