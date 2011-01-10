class UpdateUsersLoginToDowncase < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      u.update_attribute(:login, u.login.downcase)
    end
  end

  def self.down
  end
end
