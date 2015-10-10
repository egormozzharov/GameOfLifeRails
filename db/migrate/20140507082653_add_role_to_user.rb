class AddRoleToUser < ActiveRecord::Migration
  def change
      add_column :users, :isAdmin, :bool, :default => false
  end
end
