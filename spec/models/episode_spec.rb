require 'spec_helper'

describe Episode do
  describe "a new instance" do
    it { should belong_to(:season) }
  end

  describe "validation" do
    it { should validate_presence_of(:index) }
    it { should validate_presence_of(:season_id) }
  end
  
  describe "#rebuild" do
    before do
      @container = EpisodeContainerFactory.create
      @season = Factory(:season)
    end

    it "should create new Episode" do
      episode = nil
      lambda { episode = Episode.rebuild(@container, @season.id) }.should change(Episode, :count).from(0).to(1)

      episode.index.should eql(@container.meta.index)
      episode.season.should eql(@season)
    end
  end
end
