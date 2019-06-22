# == Schema Information
#
# Table name: attachments
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  description       :string
#  creator_type      :string
#  creator_id        :integer
#  item_type         :string
#  item_id           :integer
#  scope             :string
#  sort              :integer
#  original_filename :string
#  stored_filename   :string
#  file_content_type :string
#  file_size         :integer
#  image_width       :integer
#  image_height      :integer
#  image_exif        :json
#  data              :json
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Attachment < Tyr::Attachment
end
