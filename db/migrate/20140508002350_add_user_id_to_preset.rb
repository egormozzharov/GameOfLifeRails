class AddUserIdToPreset < ActiveRecord::Migration
  def change
      add_column :presets, :user_id, :integer
  end
end
