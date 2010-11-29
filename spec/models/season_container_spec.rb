require 'spec_helper'

describe SeasonContainer do
  describe "#build" do
    before do
      @index = 1
      @count_episodes = 8
      @path = SeasonRepoFactory.create(nil, @index, @count_episodes)
    end

    it "should build meta" do
      SeasonContainer.stubs(:new)
      SeasonMeta.stubs(:build).with(@path, @index).once

      SeasonContainer.build(@path, @index)
    end

    it "should build episode containers" do
      (1..@count_episodes).to_a.each do |episode_index|
        EpisodeContainer.stubs(:build).with(episode_index).once
      end

      SeasonContainer.build(@path, @index)
    end

    it "should create container instance" do
      meta = Object.new
      episodes = []

      SeasonMeta.stubs(:build).returns(meta)

      (1..@count_episodes).to_a.each do |episode_index|
        episode = Object.new
        
        EpisodeContainer.stubs(:build).with(episode_index).returns(episode)

        episodes << episode
      end
      
      SeasonContainer.stubs(:new).with(:meta => meta, :episodes => episodes).once

      SeasonContainer.build(@path, @index)
    end

    it "should return container instance" do
      result = SeasonContainer.build(@path, @index)

      result.should be_an_instance_of(SeasonContainer)
    end
  end

  describe "validation" do
    subject { SeasonContainerFactory.create }
    
    it { should validate_presence_of(:meta) }
  end

  describe "a new instance" do
    subject { SeasonContainerFactory.create }

    it "should have meta" do
      subject.meta.should be_an_instance_of(SeasonMeta)
    end

    it "should have episodes" do
      subject.episodes.should be_an_instance_of(Array)
    end
  end

end
