require 'spec_helper'

describe Season, "#index" do
  before do
    serial = Factory(:serial)
    2.times{ serial.seasons << Factory(:season) }
    serial.save!
    
    @season = serial.seasons.last
  end

  subject{ @season.index }

  it "should return index of a Season" do
    subject.should eql(2)
  end
end
