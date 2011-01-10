class UpdateUsersEmailToDowncase < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      u.update_attribute(:email, u.email.downcase)
    end
  end

  def self.down
  end
end
