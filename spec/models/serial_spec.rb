require 'spec_helper'

describe Serial do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }
  it { should have_attached_file(:poster) }
  it { should validate_attachment_presence(:poster) }

  describe "#to_param" do
    before do
      @serial = Factory(:serial)
    end

    it "should return slug attribute" do
      @serial.to_param.should eql(@serial.slug)
    end
  end

  describe "#rebuild" do
    before do
      @path = SerialRepoFactory.create
      @container = SerialContainer.build(@path)
    end

    it "should create new Serial" do
      lambda { Serial.rebuild(@container) }.should change(Serial, :count).from(0).to(1)
    end

    it "should assign attributes to just created Serial according to the meta" do
      Serial.rebuild(@container)

      serial = Serial.first

      serial.title.should eql(@container.meta.title)
      serial.slug.should eql(@container.meta.slug)
      serial.description.should eql(@container.meta.description)
    end
  end
end
