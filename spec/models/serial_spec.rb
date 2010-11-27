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

  describe "#to_param" do
    before do
      @serial = Factory(:serial)
    end

    it "shuld return slug attribute" do
      @serial.to_param.should eql(@serial.slug)
    end
  end
end
