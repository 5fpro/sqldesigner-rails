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

class Redactor2Rails::Image < Redactor2Rails::Asset
  mount_uploader :data, Redactor2RailsImageUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end
end
