require 'spec_helper'

describe Season do
  describe "validations" do
    it { should validate_presence_of(:index) }
    it { should validate_presence_of(:serial_id) }
  end

  describe "relations" do
    it { should belong_to(:serial) }
    it { should have_many(:episodes, :dependent => :destroy) }
  end

  describe "#rebuild" do
    before do
      @index = 5
      @serial = Factory(:serial)
      @count_episodes = 3
      @container = SeasonContainerFactory.create(nil, @index, @count_episodes)
    end

    it "should create new Season" do
      lambda { Season.rebuild(@container, @serial.id) }.should change(@serial.seasons, :count).from(0).to(1)
    end

    it "should rebuild Episodes" do
      season = Object.new
      season.stubs(:id).returns(99)

      Season.stubs(:create!).returns(season)

      @container.episodes.each do |episode_container|
        Episode.stubs(:rebuild).with(episode_container, season.id).once
      end

      Season.rebuild(@container, @serial.id)
    end

    it "should assign valid index to just created Season" do
      Season.rebuild(@container, @serial.id)

      Season.first.index.should eql(@index)
    end
  end
end
