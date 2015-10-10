class CreatePresets < ActiveRecord::Migration
  def change
    create_table :presets do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
