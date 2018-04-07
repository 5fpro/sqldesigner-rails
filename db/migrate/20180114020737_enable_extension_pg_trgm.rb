class EnableExtensionPgTrgm < ActiveRecord::Migration[5.1]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
    execute 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'
  end

  def down
    execute 'DROP EXTENSION fuzzystrmatch'
    execute 'DROP EXTENSION pg_trgm'
  end
end
