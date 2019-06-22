class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string  :name
      t.string  :description
      t.string  :creator_type
      t.integer :creator_id
      t.string  :item_type
      t.integer :item_id
      t.string  :scope
      t.integer :sort
      t.string  :original_filename
      t.string  :stored_filename
      t.string  :file_content_type
      t.integer :file_size
      t.integer :image_width
      t.integer :image_height
      t.json    :image_exif
      t.json    :data
      t.timestamps
    end
    add_index :attachments, [:creator_type, :creator_id]
    add_index :attachments, [:item_type, :item_id]
    add_index :attachments, [:item_type, :item_id, :sort]
    add_index :attachments, [:item_type, :item_id, :scope]
    add_index :attachments, [:item_type, :item_id, :scope, :sort]
  end
end
