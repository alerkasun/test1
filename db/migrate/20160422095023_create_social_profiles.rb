class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.string :type
      t.integer :user_id
      t.integer :social_id, limit: 8
      t.text :access_token

      t.timestamps null: false
    end
  end
end
