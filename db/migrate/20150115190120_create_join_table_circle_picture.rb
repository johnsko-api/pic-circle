class CreateJoinTableCirclePicture < ActiveRecord::Migration
  def change
    create_join_table :circles, :pictures do |t|
      # t.index [:circle_id, :picture_id]
      # t.index [:picture_id, :circle_id]
    end
  end
end
