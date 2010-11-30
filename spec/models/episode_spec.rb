require 'spec_helper'

describe Episode do
  describe "a new instance" do
    it { should belong_to(:season) }
  end

  describe "validation" do
    it { should validate_presence_of(:index) }
    it { should validate_presence_of(:season_id) }
    it { should validate_presence_of(:webm) }
    it { should validate_presence_of(:mp4) }
  end

  describe "attributes" do
    subject { Factory(:episode).attributes }
    
    it { should include('mp4') }
    it { should include('webm') }
  end
  
  describe "#import!" do
    before do
      @episode_container = ContainerFactory(:episode)
      @season = Factory(:season)
    end

    it "should create Episode with proper attributes" do
      lambda { @season.episodes.import!(@episode_container) }.should change(@season.episodes, :count).from(0).to(1)

      @season.episodes.first.index.should eql(@episode_container.attributes[:index])
    end
  end
end
