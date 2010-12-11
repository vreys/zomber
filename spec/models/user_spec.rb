require 'spec_helper'

describe User do
  it { should be_an_invitable }
  it { should have_column(:name, :type => :string) }
end
