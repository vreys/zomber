class AddAltTitleToSerials < ActiveRecord::Migration
  def self.up
    add_column :serials, :alt_title, :string
  end

  def self.down
    remove_column :serials, :alt_title
  end
end
