class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string  :actor_type
      t.integer :actor_id
      t.string  :action
      t.string  :target_type
      t.integer :target_id
      t.date    :acted_on
      t.json    :data
      t.timestamps
    end
    add_index :activities, [:actor_type, :actor_id]
    add_index :activities, [:target_type, :target_id]
    add_index :activities, [:action]
    add_index :activities, [:acted_on]
  end
end
