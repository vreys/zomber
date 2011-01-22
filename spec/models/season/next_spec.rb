require "spec_helper"

describe Season, "#next" do
  context "when :index_number is eql to count seasons" do
    subject{ Factory(:season) }
    
    it "should return nil" do
      subject.next.should be_nil
    end
  end

  context "when :index_number is not last" do
    before do
      @serial = Factory(:serial)

      3.times do
        @serial.seasons.create
      end

      @expected_season = @serial.seasons.find_by_index_number(3)
    end

    subject{ @serial.seasons.find_by_index_number(2).next }
    
    it "should return Season with :index_number + 1" do
      subject.should eql(@expected_season)
    end
  end
end
