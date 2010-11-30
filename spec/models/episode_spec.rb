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

  describe "#first?" do
    before do
      @season = Factory(:season)

      (1..2).to_a.each do |index|
        Factory(:episode, :index => index, :season => @season)
      end
    end

    context "when this is not first episode in season" do
      subject { @season.episodes.last.first? }
      
      it { should be(false)}
    end

    context "when this is first episode in season" do
      subject { @season.episodes.first.first? }
      
      it { should be(true)}
    end
  end

  describe "#last?" do
    before do
      @season = Factory(:season)

      (1..2).to_a.each do |index|
        Factory(:episode, :index => index, :season => @season)
      end
    end

    context "when this is not last episode in season" do
      subject { @season.episodes.first.last? }
      
      it { should be(false) }
    end
    
    context "when this is last episode in season" do
      subject { @season.episodes.last.last? }

      it { should be(true) }
    end
  end

  describe "#previous" do
    before do
      @season = Factory(:season)

      (1..2).to_a.each do |index|
        Factory(:episode, :index => index, :season => @season)
      end
    end

    context "when this is not first episode in season" do
      it "should return previous episode" do
        @season.episodes.last.previous.should eql(@season.episodes.first)
      end
    end

    context "when this is first episode in season" do
      subject { @season.episodes.first.previous }
      it { should be_nil }
    end
  end

  describe "#next" do
    before do
      @season = Factory(:season)

      (1..2).to_a.each do |index|
        Factory(:episode, :index => index, :season => @season)
      end
    end

    context "when this is not last episode in season" do
      it "should return next episode" do
        @season.episodes.first.next.should eql(@season.episodes.last)
      end
    end

    context "when this is last episode in season" do
      subject { @season.episodes.last.next }
      it { should be_nil }
    end
  end
end
