class ChangeUserEmailField < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true, default: nil
  end
end
