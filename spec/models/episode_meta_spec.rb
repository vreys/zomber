require 'spec_helper'

describe EpisodeMeta do
  describe "a new instance" do
    before do
      @index = 6
    end

    subject { EpisodeMeta.new(@index) }
    
    it "should have index" do
      subject.index.should eql(@index)
    end
  end
end
