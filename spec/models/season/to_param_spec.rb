require "spec_helper"

describe Season, "#to_param" do
  before do
    serial = Factory(:serial)
    3.times{ serial.seasons << Factory(:season) }
    serial.save!
    
    @season = serial.seasons.last
  end
  
  subject { @season.to_param }
  
  it "should return index of a Season as a String" do
    subject.should eql(@season.index.to_s)
  end
end
