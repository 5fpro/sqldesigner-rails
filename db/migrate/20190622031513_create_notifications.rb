class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :sender_type
      t.string :sender_id
      t.string :receiver_type
      t.string :receiver_id
      t.string :object_type
      t.string :object_id
      t.string :notify_type
      t.boolean :readed, default: false
      t.string :subject
      t.string :body
      t.date   :created_on
      t.json :data
      t.timestamps
    end
    add_index :notifications, :notify_type
    add_index :notifications, [:sender_type, :sender_id]
    add_index :notifications, [:receiver_type, :receiver_id]
    add_index :notifications, [:object_type, :object_id]
    add_index :notifications, [:readed, :receiver_type, :receiver_id]
    add_index :notifications, :created_on
    execute 'CREATE INDEX trgm_notifications_body_idx ON notifications USING gist (body gist_trgm_ops);'
    execute 'CREATE INDEX trgm_notifications_subject_idx ON notifications USING gist (subject gist_trgm_ops);'
  end
end
