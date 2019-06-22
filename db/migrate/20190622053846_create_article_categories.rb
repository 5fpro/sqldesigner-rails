class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.string :layout, comment: '版位'
      t.string :name, comment: '名稱'
      t.boolean :enabled, default: true, comment: '是否顯示'
      t.integer :sort, comment: '排序'
      t.integer :parent_id, comment: '上層分類'
      t.integer :deep, default: 0, comment: '目前分層的深度'
      t.integer :articles_count, default: 0, comment: '文章數'
      t.datetime :deleted_at
      t.jsonb :data
      t.timestamps
    end
    add_index :article_categories, :layout
    add_index :article_categories, [:layout, :enabled]
    add_index :article_categories, [:layout, :enabled, :sort]
    add_index :article_categories, [:layout, :parent_id]
    add_index :article_categories, [:layout, :deep]
    execute 'CREATE INDEX trgm_article_categories_name_idx ON article_categories USING gist (name gist_trgm_ops);'
  end
end
