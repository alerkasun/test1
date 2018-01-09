class CreatePrayers < ActiveRecord::Migration[5.0]
  def up
    create_table :prayers do |t|
      t.references  :user,          null: true, index: true
      t.text        :text,          null: false
      t.text        :description,   null: true
      t.boolean     :is_free,       null: false, default: true
      t.boolean     :is_published,  null: false, default: false
      t.timestamps                  null: false
    end
  end

  def down
    drop_table :prayers
  end
end
