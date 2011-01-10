class RenameNameToLoginInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :login
  end

  def self.down
    rename_column :users, :login, :name
  end
end
