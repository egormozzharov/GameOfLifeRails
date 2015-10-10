class AddDefaultThemeToUser < ActiveRecord::Migration
  def change
      change_column :users, :theme, :string, :default => 'light'
  end
end
