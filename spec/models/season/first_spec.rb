require "spec_helper"

describe Season, "#first?" do
  before do
    @serial = Factory(:serial)
  end

  context "when :index_number = 1" do
    subject{ @serial.seasons.create.first? }
    
    it { should be_true }
  end

  context "when :index_number > 1" do
    before{ @serial.seasons.create }
    subject{ @serial.seasons.create.first? }

    it { should be_false }
  end
end
