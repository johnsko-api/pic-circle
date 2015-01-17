class AddIsPrivateToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :is_private, :boolean, :default => false, null: false
  end
end
