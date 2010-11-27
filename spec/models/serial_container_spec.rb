require 'spec_helper'

describe SerialContainer do
  describe "#build" do
    context "when calling with path to an existant serial directory" do
      before do
        @count_seasons = 5
        @path = SerialRepoFactory.create(:count_seasons => @count_seasons)
      end

      it "should build serial meta" do
        SerialMeta.stubs(:build).with(@path).once

        SerialContainer.build(@path)
      end

      it "should build season containers" do
        (1..@count_seasons).to_a.each do |index|
          SeasonContainer.stubs(:build).with(File.join(@path, "season #{index}").to_s, index).once
        end

        SerialContainer.build(@path)
      end

      it "should create new container instance" do
        meta = Object.new
        SerialMeta.stubs(:build).returns(meta)

        seasons = []
        (1..@count_seasons).to_a.each do |index|
          season = Object.new
          SeasonContainer.stubs(:build).with(File.join(@path, "season #{index}").to_s, index).returns(season)

          seasons << season
        end
        
        SerialContainer.stubs(:new).with(:meta => meta, :seasons => seasons).once
        SerialContainer.build(@path)
      end

      it "should return serial container" do
        result = SerialContainer.build(@path)
        result.should be_an_instance_of(SerialContainer)
      end
    end

    context "when calling with path to a not existant serial directory" do
      before do
        @path = Rails.root.join('tmp', 'path', 'that', 'do', 'not', 'exists').to_s
      end

      it "should return nil" do
        result = SerialContainer.build(@path)
        result.should be_nil
      end
    end
  end

  describe "validations" do
    subject { SerialContainerFactory.create }

    it { should validate_presence_of(:meta) }
  end

  describe "a new instance" do
    subject { SerialContainerFactory.create }

    it "should have seasons" do
      subject.seasons.should be_an_instance_of(Array)
    end

    it "should have meta" do
      subject.meta.should be_an_instance_of(SerialMeta)
    end
  end
end
