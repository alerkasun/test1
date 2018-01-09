class CreateProfilesTable < ActiveRecord::Migration
  def up
    create_table :profiles do |t|
      t.string :first_name,    null: true
      t.string :last_name,     null: true
      t.references :profileable, polymorphic: true, null: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :profiles
  end
end
