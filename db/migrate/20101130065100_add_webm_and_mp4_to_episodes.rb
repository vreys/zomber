class AddWebmAndMp4ToEpisodes < ActiveRecord::Migration
  def self.up
    add_column :episodes, :mp4, :text
    add_column :episodes, :webm, :text
  end

  def self.down
    remove_column :episodes, :mp4
    remove_column :episodes, :webm
  end
end
