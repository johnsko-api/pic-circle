class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
