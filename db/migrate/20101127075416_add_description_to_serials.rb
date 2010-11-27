class AddDescriptionToSerials < ActiveRecord::Migration
  def self.up
    add_column :serials, :description, :text
  end

  def self.down
    remove_column :serials, :description
  end
end
