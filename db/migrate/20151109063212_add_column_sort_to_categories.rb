class AddColumnSortToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :sort, :integer
    add_index :categories, :sort
  end
end
