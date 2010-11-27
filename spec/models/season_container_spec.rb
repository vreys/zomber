require 'spec_helper'

describe SeasonContainer do
  describe "#build" do
    before do
      @index = 1
      @path = SeasonRepoFactory.create(nil, @index)
    end

    it "should build meta" do
      SeasonContainer.stubs(:new)
      SeasonMeta.stubs(:build).with(@path, @index).once

      SeasonContainer.build(@path, @index)
    end

    it "should create container instance with just builded meta" do
      meta = Object.new

      SeasonMeta.stubs(:build).returns(meta)
      SeasonContainer.stubs(:new).with(:meta => meta).once

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
  end

end
