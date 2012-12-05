class AddColumnUserIdToErds < ActiveRecord::Migration
  def change
    add_column :erds, :user_id, :integer, :after => :id
    add_index :erds, :user_id
  end
end
