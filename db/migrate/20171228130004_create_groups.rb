class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.belongs_to :prayer, index: true
      t.string :name
    end
  end
end
