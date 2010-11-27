class AddSlugToSerials < ActiveRecord::Migration
  def self.up
    add_column :serials, :slug, :string
  end

  def self.down
    remove_column :serials, :slug
  end
end
