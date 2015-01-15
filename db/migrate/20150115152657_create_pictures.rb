class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id, null: false
      t.integer :circle_id, null: false
      t.string :image, null: false

      t.timestamps null: false
    end
  end
end
