class CreateErds < ActiveRecord::Migration
  def change
    create_table :erds do |t|
      t.string :keyword
      t.text :data
      t.timestamps
    end
    add_index :erds, [:keyword], :unique => true
  end
end
