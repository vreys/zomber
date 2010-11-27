class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.integer :serial_id
      t.integer :index

      t.timestamps
    end
  end

  def self.down
    drop_table :seasons
  end
end
