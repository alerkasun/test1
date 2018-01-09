class CreateDevices < ActiveRecord::Migration
  execute <<-SQL
    CREATE TYPE platform_list AS ENUM ('ios', 'android');
  SQL

  def change
    create_table :devices do |t|
      t.string :device_id, null: false, unique: true, index: true
      t.references :deviceble, polymorphic: true, null: false, index: true
      t.column :platform, :platform_list, null: false, default: 'ios'
      t.string :push_token
      t.boolean :enabled
    end
  end
end
