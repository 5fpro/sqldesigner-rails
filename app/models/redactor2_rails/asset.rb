# == Schema Information
#
# Table name: redactor2_assets
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  data_file_name    :string           not null
#  data_content_type :string
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Redactor2Rails::Asset < ApplicationRecord
  include Redactor2Rails::Orm::ActiveRecord::AssetBase

  delegate :url, :current_path, :size, :content_type, :filename, to: :data
  validates :data, presence: true
end
