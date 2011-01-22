require "spec_helper"

describe Episode, "#find_by_index" do
  before do
    @season = Factory(:season)
    3.times{ Factory(:episode, :season => @season) }

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
