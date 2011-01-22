require "spec_helper"

describe Season, "#to_param" do
  before do
    @serial = Factory(:serial)

    (rand(5)+2).times{ @serial.seasons.create }

    @expected_result = @serial.seasons.last.index_number.to_s
  end
  
  subject { @serial.seasons.last.to_param }
  
  it "should return :index_number of a Season as a String" do
    subject.should eql(@expected_result)
  end
end
