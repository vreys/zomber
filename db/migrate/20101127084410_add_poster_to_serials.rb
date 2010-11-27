class AddPosterToSerials < ActiveRecord::Migration
  def self.up
    add_column :serials, :poster_file_name,    :string
    add_column :serials, :poster_content_type, :string
    add_column :serials, :poster_file_size,    :integer
    add_column :serials, :poster_updated_at,   :datetime
  end

  def self.down
    remove_column :serials, :poster_file_name
    remove_column :serials, :poster_content_type
    remove_column :serials, :poster_file_size
    remove_column :serials, :poster_updated_at
  end
end
