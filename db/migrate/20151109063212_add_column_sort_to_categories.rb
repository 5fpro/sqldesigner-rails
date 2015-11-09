class AddColumnSortToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sort, :integer
    add_index :categories, :sort
  end
end
