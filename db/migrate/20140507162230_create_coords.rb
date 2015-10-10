class CreateCoords < ActiveRecord::Migration
  def change
    create_table :coords do |t|
      t.integer :preset_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
