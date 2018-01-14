class RemoveAdminFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :admin
    remove_column :users, :admin
  end
end
