create_table "schema_migrations", collate: "utf8_bin", comment: "" do |t|
  t.varchar "version"

  t.index "version", name: "unique_schema_migrations", unique: true
end

create_table :users, collate: "utf8_bin" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :character_id, null: true
  t.varchar :name, null: true
  t.int :corporation_id, null: true
  t.int :alliance_id, null: true
  t.boolean :is_main, null: true
  t.int :main_character_id, null: true
  t.int :sign_in_count, default: 0
  t.varchar :login_token, null:true
  t.varchar :access_token, null:true
  t.text :refresh_token, null:true
  t.datetime :expire, null:true
  t.datetime :created_at
  t.datetime :updated_at
end

create_table :assets, collate: "utf8_bin" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :user_id
  t.boolean :is_singleton, null: true
  t.bigint :item_id, null: true
  t.varchar :location_flag, null: true
  t.bigint :location_id, null: true
  t.varchar :location_type, null: true
  t.int :quantity, null: true
  t.int :type_id, null: true
  t.datetime :created_at
  t.datetime :updated_at
end

create_table :corporations, collate: "utf8_bin" do |t|
  t.int :corporation_id, primary_key: true
  t.varchar :corporation_name
  t.datetime :created_at
  t.datetime :updated_at
end

create_table :corporation_relations, collate: "utf8_bin" do |t|
  t.int :id, primary_key: true, extra: 'auto_increment'
  t.int :ancestor
  t.int :descendant

  t.datetime :created_at, null: true
  t.datetime :updated_at, null: true

  t.index :ancestor
  t.index :descendant
end

create_table :delayed_jobs, comment: 'Delayed Job' do |t|
  t.int :id, primary_key: true, extra: 'auto_increment'
  t.int :priority, default: 0, null: false
  t.int :attempts, default: 0, null: false
  t.text :handler
  t.text :last_error, null: true
  t.datetime :run_at, null: true
  t.datetime :locked_at, null: true
  t.datetime :failed_at, null: true
  t.varchar :locked_by, null: true
  t.varchar :queue, null: true

  t.datetime :created_at, null: true, comment: '作成日時'
  t.datetime :updated_at, null: true, comment: '更新日時'

  t.index [:priority, :run_at], name: 'delayed_jobs_priority'
end
