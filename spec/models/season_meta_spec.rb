require 'spec_helper'

describe SeasonMeta do
  describe "#build" do
    before do
      @path = nil
      @index = 1
    end

    it "should create new meta with proper index" do
      SeasonMeta.stubs(:new).with(@path, @index).once
      SeasonMeta.build(@path, @index)
    end

    it "should return meta" do
      result = SeasonMeta.build(@path, @index)
      result.should be_an_instance_of(SeasonMeta)
    end
  end

  describe "validation" do
    subject { SeasonMetaFactory.create }

    it { should validate_presence_of(:index) }
  end

  describe "a new instance" do
    subject { SeasonMetaFactory.create }

    it "should have index" do
      subject.index.should_not be_nil
    end
  end
end
