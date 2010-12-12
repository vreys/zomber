require 'spec_helper'

describe User do
  it { should be_an_invitable }
  it { should have_column(:name, :type => :string) }
  it { should allow_mass_assignment_of(:email, :name) }
  it { should_not be_a_registerable }
  it { should be_a_database_authenticatable }
  it { should be_a_rememberable }
end
