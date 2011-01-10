class User < ActiveRecord::Base
  validates_presence_of :login
  validates_uniqueness_of :login

  validates_uniqueness_of :email
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :rememberable, :validatable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :login, :password, :password_confirmation, :remember_me

  protected

  def self.find_for_database_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["login = :value OR email = :value", { :value => login }]).first
  end
end
