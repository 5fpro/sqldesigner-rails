class CreateEventLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :event_logs do |t|
      t.string :event_type
      t.string :description
      t.string :identity
      t.date   :created_on
      t.json :data
      t.timestamps
    end
    add_index :event_logs, :event_type
    add_index :event_logs, [:event_type, :identity]
    add_index :event_logs, :created_on
  end
end
