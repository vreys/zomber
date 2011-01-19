require 'spec_helper'

describe Serial, "#to_param" do
  subject { Factory(:serial) }

  it "should return :permalink" do
    subject.to_param.should eql(subject.permalink)
  end
end
