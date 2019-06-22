class CreatePageBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :page_blocks do |t|
      t.string  :name
      t.text    :body
      t.boolean :enabled, default: false
      t.timestamps
    end
    add_index :page_blocks, :name
    add_index :page_blocks, :enabled
  end
end
