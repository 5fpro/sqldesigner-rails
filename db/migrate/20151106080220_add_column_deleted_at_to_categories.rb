class AddColumnDeletedAtToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :deleted_at, :datetime
  end
end
