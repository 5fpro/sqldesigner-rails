class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :layout, comment: '版位'
      t.integer :article_category_id, comment: '文章分類'
      t.string :subject, comment: '標題'
      t.string :summary, comment: '摘要'
      t.text :body, comment: '內文'
      t.integer :cover_id, comment: '封面照片，attachment id'
      t.date :published_on, comment: '發佈日期'
      t.datetime :published_at, comment: '發佈日期+時間'
      t.string :author_name, comment: '作者名稱'
      t.string :author_type
      t.integer :author_id
      t.integer :status, comment: '狀態'
      t.boolean :top, default: false
      t.string :meta_title, comment: 'SEO 標題'
      t.string :meta_description, comment: 'SEO 描述'
      t.string :meta_keywords, comment: 'SEO 關鍵字'
      t.datetime :deleted_at
      t.jsonb :data
      t.timestamps
    end
    add_index :articles, :layout
    add_index :articles, [:layout, :article_category_id]
    add_index :articles, [:layout, :published_on]
    add_index :articles, [:layout, :author_type, :author_id]
    add_index :articles, [:layout, :author_name]
    add_index :articles, [:layout, :status]
    add_index :articles, [:layout, :top]
    execute 'CREATE INDEX trgm_articles_subject_idx ON articles USING gist (subject gist_trgm_ops);'
    execute 'CREATE INDEX trgm_articles_body_idx ON articles USING gist (body gist_trgm_ops);'
    execute 'CREATE INDEX trgm_articles_summary_idx ON articles USING gist (summary gist_trgm_ops);'
    execute 'CREATE INDEX trgm_articles_author_name_idx ON articles USING gist (author_name gist_trgm_ops);'
  end
end
