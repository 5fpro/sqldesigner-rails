class CreateAuthorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :authorizations do |t|
      t.integer :provider
      t.string  :uid
      t.string  :auth_type
      t.integer :auth_id
      t.text    :auth_data
      t.hstore  :data
      t.timestamps null: false
    end
    add_index :authorizations, [:provider, :uid]
    add_index :authorizations, [:auth_type, :auth_id]
    add_index :authorizations, [:auth_type, :auth_id, :provider]
  end
end
