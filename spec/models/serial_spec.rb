require 'spec_helper'

describe Serial do
  describe "default scope" do
    before do
      5.times{ Factory(:serial) }
    end
    
    it "should return Serials ordered by title ascending" do
      Serial.all.to_a.should eql(Serial.ascending("title").to_a)
    end
  end
  
  context "after save" do
    it "should have permalink as parameterized original_title" do
      serial = Factory(:serial, :original_title => 'House M.D.')

      serial.permalink.should eql(serial.original_title.parameterize)
    end
  end

  describe "#to_param" do
    subject { Factory(:serial) }

    it "should return :permalink" do
      subject.to_param.should eql(subject.permalink)
    end
  end

  describe "#find_by_permalink" do
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
end
