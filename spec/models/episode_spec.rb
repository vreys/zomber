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

  describe "#find_by_index" do
    before do
      @season = Factory(:season)
      3.times{ @season.episodes << Factory(:episode) }

      @request_index = 2
      @expected_episode = @season.episodes.at(@request_index-1)
    end

    context "when request index is passed as an Integer" do
      subject{ @season.episodes.find_by_index(@request_index.to_i) }

      it "should return Season with requested index" do
        subject.should eql(@expected_episode)
      end
    end

    context "when request index is passed as a String" do
      subject{ @season.episodes.find_by_index(@request_index.to_s) }

      it "should return Season with requested index" do
        subject.should eql(@expected_episode)
      end
    end
  end
end
