# == Schema Information
#
# Table name: articles
#
#  id                  :bigint(8)        not null, primary key
#  layout              :string
#  article_category_id :integer
#  subject             :string
#  summary             :string
#  body                :text
#  cover_id            :integer
#  published_on        :date
#  published_at        :datetime
#  author_name         :string
#  author_type         :string
#  author_id           :integer
#  status              :integer
#  top                 :boolean          default(FALSE)
#  meta_title          :string
#  meta_description    :string
#  meta_keywords       :string
#  deleted_at          :datetime
#  data                :jsonb
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Article < Tyr::Article
end
