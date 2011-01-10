require 'spec_helper'

describe User do
  it { should be_an_invitable }
  it { should have_column(:login, :type => :string) }
  it { should allow_mass_assignment_of(:email, :login) }
  it { should_not be_a_registerable }
  it { should be_a_database_authenticatable(:authentication_keys => [:login]) }
  it { should be_a_rememberable }
  it { should be_a_validatable }
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should be_a_recoverable }

  context "given two users" do
    before do
      2.times{ Factory(:user) }
    end

    it { should validate_uniqueness_of(:login) }
    it { should validate_uniqueness_of(:email) }
  end
end
