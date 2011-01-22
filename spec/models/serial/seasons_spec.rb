require "spec_helper"

describe Season, "#seasons" do
  describe "#find_by_index_number" do
    before do
      @serial = Factory(:serial)
      3.times { @serial.seasons.create }

      @requested_index_number = 3
      @expected_season = @serial.seasons.last
    end

    context "when Season with the passed index number doesn't exists" do
      subject{ @serial.seasons.find_by_index_number(99) }
      
      it "should return nil" do
        subject.should be_nil
      end
    end

    context "when Season with the passed index number is exists" do
      context "when passed index number as an Integer" do
        subject{ @serial.seasons.find_by_index_number(@requested_index_number.to_i) }

        it "should return Season" do
          subject.should eql(@expected_season)
        end
      end

      context "when passed index number as a String" do
        subject{ @serial.seasons.find_by_index_number(@requested_index_number.to_s) }

        it "should return Season" do
          subject.should eql(@expected_season)
        end
      end
    end
  end
end
