require "spec_helper"

describe Season, "#previous" do
  before do
    @serial = Factory(:serial)
  end

  context "when Season#index_number = 1" do
    subject{ @serial.seasons.create }
    
    it "should return nil" do
      subject.previous.should be_nil
    end
  end
  
  context "when Season#index_number > 1" do
    before do
      3.times{ @serial.seasons.create }
      
      @index_number = 3
    end

    subject{ @serial.seasons.find_by_index_number(@index_number) }

    it "should return Season with previous :index_number" do
      subject.previous.index_number.should eql(@index_number - 1)
    end
  end
end
