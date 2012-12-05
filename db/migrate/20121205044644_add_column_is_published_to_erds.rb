class AddColumnIsPublishedToErds < ActiveRecord::Migration
  def change
    add_column :erds, :is_published, :boolean, :default => true, :after => :user_id
    add_index :erds, [:is_published]
  end
end
