class RemoveIndexOfKeywordInErds < ActiveRecord::Migration
  def up
    remove_index :erds, :keyword
    add_index :erds, [:keyword, :user_id], :unique => true
  end

  def down
  end
end
