class AddColumnFacebookIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string, :after => :encrypted_password
    add_index :users, [:facebook_id]
  end
end
