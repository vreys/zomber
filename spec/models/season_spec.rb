require 'spec_helper'

describe Season do
  describe "validations" do
    it { should validate_presence_of(:index) }
    it { should validate_presence_of(:serial_id) }
  end

  describe "relations" do
    it { should belong_to(:serial) }
  end

  describe "#rebuild" do
    before do
      @index = 5
      @serial = Factory(:serial)
      @container = SeasonContainerFactory.create(nil, @index)
    end

    it "should create new Season" do
      lambda { Season.rebuild(@container, @serial.id) }.should change(@serial.seasons, :count).from(0).to(1)
    end

    it "should assign valid index to just created Season" do
      Season.rebuild(@container, @serial.id)

      Season.first.index.should eql(@index)
    end
  end
end
