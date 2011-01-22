require "spec_helper"

describe Season, "#last?" do
  before do
    @serial = Factory(:serial)

    no_more_than(8).upto(16).each do
      @serial.seasons.create
    end
  end

  context "when :index_number is eql to count seasons" do
    subject{ @serial.seasons.last }

    it "should return true" do
      subject.last?.should be_true
    end
  end

  context "when :index_number is less than count seasons" do
    subject{ @serial.seasons.fourth }

    it "should return false" do
      subject.last?.should be_false
    end
  end
end
