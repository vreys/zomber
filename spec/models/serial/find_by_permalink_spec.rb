require 'spec_helper'

describe Serial, "#find_by_permalink" do
  context "when Serial with requested permalink exists" do
    before do
      2.times { Factory(:serial) }

      @permalink = Serial.last.permalink
    end

    it "should return one serial with requested :permalink" do
      Serial.find_by_permalink(@permalink).should eql(Serial.last)
    end
  end

  context "when Serial with requested permalink doesn't exists" do
    before do
      Factory(:serial, :original_title => "Foo bar baz")
    end
    
    it "should return nil" do
      Serial.find_by_permalink("house-md").should be_nil
    end
  end
end
