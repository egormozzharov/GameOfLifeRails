class RenameThemeForThemeColor < ActiveRecord::Migration
  def change
      change_table :users do |t|
          t.rename :theme, :theme_color
      end
  end

end
