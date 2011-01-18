require 'spec_helper'

describe Season do
  describe "#index" do
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

  describe "#to_param" do
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

  describe "#find_by_index" do
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
end
