class AddColumnNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :after => :id
  end
end
