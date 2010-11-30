require 'spec_helper'

describe SeasonContainer do
  context "after method new is called with path to season repository" do
    before do
      attrs = {
        :index => 7
      }
      
      season_path = RepositoryFactory(:season, attrs)
      @season_container = SeasonContainer.new(attrs.merge(:path => season_path))
      
      @expected_attributes = attrs
    end

    it "should properly read meta into attributes" do
      @season_container.attributes.should eql(@expected_attributes)
    end

    describe "episodes" do
      before do
        index = 7
        
        season_path = RepositoryFactory(:season,
                                        :count_episodes => 0,
                                        :index => index)

        @episode_paths = []
        
        7.times.to_a.each do |index|
          @episode_paths << RepositoryFactory(:episode,
                                              :season_repo_path => season_path,
                                              :index => (index+1))
        end

        @season_container = SeasonContainer.new(:path => season_path,
                                                :index => index)
      end

      it "should create EpisodeContainer for each episode" do
        @episode_paths.each_with_index do |attrs, index|
          EpisodeContainer.stubs(:new).with(attrs.merge(:index => (index+1))).once
        end

        @season_container.episodes
      end

      it "should return array of EpisodeContainers" do
        @season_container.episodes.map{|e| e.class}.uniq.should eql [EpisodeContainer]
      end
    end
  end
end
