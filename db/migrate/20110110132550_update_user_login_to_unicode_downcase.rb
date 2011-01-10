class UpdateUserLoginToUnicodeDowncase < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      u.update_attribute(:login, Unicode.downcase(u.login))
    end
  end

  def self.down
  end
end
