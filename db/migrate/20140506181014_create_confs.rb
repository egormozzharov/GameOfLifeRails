class CreateConfs < ActiveRecord::Migration
  def change
    create_table :confs do |t|
      t.string :name
      t.integer :user_id
      t.string :alive
      t.string :die
      t.string :desc

      t.timestamps
    end
  end
end
