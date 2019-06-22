class CreateErds < ActiveRecord::Migration[5.2]
  def change
    create_table :erds do |t|
      t.integer  :user_id
      t.boolean  :is_published, default: true
      t.string :keyword
      t.text :data
      t.timestamps
    end
    add_index :erds, :keyword
    add_index :erds, :user_id
    add_index :erds, :is_published
  end
end
