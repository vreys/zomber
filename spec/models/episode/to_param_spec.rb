require "spec_helper"

describe Episode, "#to_param" do
  before do
    @season = Factory(:season)

    no_more_than(8).times{ Factory(:episode, :season => @season) }

    @expected_result = @season.episodes.last.index.to_s
  end

  subject{ @season.episodes.last.index }

  it "should return :index of an Episode as a String" do
    subject.to_param.should eql(@expected_result)
  end
end
