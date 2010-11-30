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

  describe "#import" do
    before do
      @season_container = ContainerFactory(:season)
      @serial = Factory(:serial)
    end

    it "should create Season with proper attributes" do
      lambda { @serial.seasons.import!(@season_container) }.should change(@serial.seasons, :count).from(0).to(1)

      @serial.seasons.first.index.should eql(@season_container.attributes[:index])
    end

    it "should import Episodes" do
      @season_container.episodes.each do |episode_container|
        Episode.stubs(:import!).with(episode_container).once
      end

      @serial.seasons.import!(@season_container)
    end
  end
end
