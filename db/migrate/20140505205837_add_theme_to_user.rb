class AddThemeToUser < ActiveRecord::Migration
  def change
      add_column :users, :theme, :string
  end
end
