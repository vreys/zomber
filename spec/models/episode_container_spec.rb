require 'spec_helper'

describe EpisodeContainer do
  describe "#build" do
    before do
      @index = 1
    end

    it "should create meta instance" do
      EpisodeMeta.stubs(:new).with(@index).once

      EpisodeContainer.build(@index)
    end

    it "should create container instance" do
      meta = EpisodeMeta.new(@index)

      EpisodeMeta.stubs(:new).returns(meta)
      EpisodeContainer.stubs(:new).with(:meta => meta).once

      EpisodeContainer.build(@index)
    end

    it "should return container instance" do
      result = EpisodeContainer.build(@index)
      result.should be_an_instance_of(EpisodeContainer)
    end
  end

  describe "validation" do
    subject { EpisodeContainer.build(1) }

    it { should validate_presence_of(:meta) }
  end

  describe "a new instance" do
    subject { EpisodeContainer.build(1) }

    it "should have meta" do
      subject.meta.should be_an_instance_of(EpisodeMeta)
    end
  end
end
