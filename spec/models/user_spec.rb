# -*- coding: undecided -*-
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

  context "after save" do
    subject { Factory(:user, :login => 'VASKO', :email => "Pupkin.Vasily@example.com") }
    
    it "should have login in lower case" do
      subject.login.should eql('vasko')
    end

    it "should have email in lower case" do
      subject.email.should eql('pupkin.vasily@example.com')
    end

    it "should have unicode login in lower case" do
      Factory(:user, :login => 'Василий Рейс')

      User.first.login.should eql('василий рейс')
    end
  end

  describe "find_for_database_authentication" do
    it "should find user by login insensitive" do
      user = Factory(:user, :login => 'vasko')
      
      User.find_for_database_authentication(:login => 'VaskO').should eql(user)
    end

    it "should find user by email insensitive" do
      user = Factory(:user, :email => 'pat@example.com')
      
      User.find_for_database_authentication(:login => 'pAt@example.com').should eql(user)
    end
  end

  it "should validate uniqueness of login insensitive" do
    Factory(:user, :login => 'vasko')

    u = Factory.build(:user, :login => 'Vasko')

    lambda { u.save }.should_not change(User, :count)
    
    u.valid?.should be_false
    u.errors.should include(:login)
  end

  it "should validate uniqueness of email insensitive" do
    Factory(:user, :email => 'reys.vasily@gmail.com')

    u = Factory.build(:user, :email => 'Reys.Vasily@gmail.com')

    lambda { u.save }.should_not change(User, :count)

    u.valid?.should be_false
    u.errors.should include(:email)
  end
end
