require 'spec_helper'

describe Episode do
  describe "#index" do
    before do
      @season = Factory(:season)
      @count_episodes = 5
      @count_episodes.times{ @season.episodes << Factory(:episode) }

      @episode = @season.episodes.last
    end

    it "should return index of an Episode" do
      @episode.index.should eql(@count_episodes)
    end
  end

  describe "#to_param" do
    before do
      season = Factory(:season)
      @count_episodes = 8
      @count_episodes.times{ season.episodes << Factory(:episode) }

      @episode = season.episodes.last
    end

    it "should return index of an Episode as a String" do
      @episode.to_param.should eql(@count_episodes.to_s)
    end
  end
end
