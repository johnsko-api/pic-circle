class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string, null: false
  end
end
