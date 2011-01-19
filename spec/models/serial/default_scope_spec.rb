require 'spec_helper'

describe Serial, "#default_scope" do
  before do
    5.times{ Factory(:serial) }
  end
  
  it "should return Serials ordered by title ascending" do
    Serial.all.to_a.should eql(Serial.ascending("title").to_a)
  end
end
