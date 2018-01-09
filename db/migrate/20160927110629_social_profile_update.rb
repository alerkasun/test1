class SocialProfileUpdate < ActiveRecord::Migration[5.0]
  def change
    change_table :social_profiles do |t|
      t.change :social_id, :string
      t.rename :type, :provider
      t.string :access_secret
    end
  end
end
