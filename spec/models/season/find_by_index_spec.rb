require "spec_helper"

describe Season, "#find_by_index" do
  before do
    @serial = Factory(:serial)
    3.times { @serial.seasons << Factory(:season) }

    @requested_index = 3
    @expected_season = @serial.seasons.last
  end

  context "when passed index as Integer" do
    subject{ @serial.seasons.find_by_index(@requested_index.to_i) }

    it "should return Season" do
      subject.should eql(@expected_season)
    end
  end

  context "when passed index as String" do
    subject{ @serial.seasons.find_by_index(@requested_index.to_s) }

    it "should return Season" do
      subject.should eql(@expected_season)
    end
  end
end
