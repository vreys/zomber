require 'spec_helper'

describe Serial do
  it "should validate presence of title" do
    serial = Factory.build(:serial, :title => nil)
    
    lambda { serial.save }.should_not change(Serial, :count).from(0).to(1)

    serial.errors.should_not be_empty
    serial.errors.should include(:title)
  end

  it "should validate presence of slug" do
    serial = Factory.build(:serial, :slug => nil)

    lambda { serial.save }.should_not change(Serial, :count).from(0).to(1)

    serial.errors.should_not be_empty
    serial.errors.should include(:slug)
  end

  it "should validate presence of description" do
    serial = Factory.build(:serial, :description => nil)

    lambda { serial.save }.should_not change(Serial, :count).from(0).to(1)

    serial.errors.should_not be_empty
    serial.errors.should include(:description)
  end

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
end
