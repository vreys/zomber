require 'spec_helper'

describe Episode, "#index" do
  before do
    @season = Factory(:season)
    @count_episodes = 5
    @count_episodes.times{ Factory(:episode, :season => @season) }

    @episode = @season.episodes.last
  end

  it "should return index of an Episode" do
    @episode.index.should eql(@count_episodes)
  end
end
