require 'spec_helper'

describe Season do
  it { should have_field :index_number, :type => Integer }

  it { should validate_uniqueness_of :index_number }
end

describe Season, "new record" do
  context "when it's a first Season in serial" do
    before do
      @serial = Factory(:serial)
    end

    subject{ @serial.seasons.create }

    it "should have :index_number = 1" do
      subject.index_number.should eql(1)
    end
  end

  context "when it's a not first Season in serial" do
    before do
      @serial = Factory(:serial)

      (rand(6)+1).times do
        @serial.seasons.create
      end

      @last = @serial.seasons.last
    end

    subject{ @serial.seasons.create }

    it "should have :index_number increamented by 1" do
      subject.index_number.should eql(@last.index_number+1)
    end
  end
end

describe Season, "after record destroyed" do
  before do
    @serial = Factory(:serial)

    5.times { @serial.seasons.create }
  end

  it "should update :index_number of other seasons" do
    @serial.seasons[3].destroy
    
    @serial.seasons.map(&:index_number).should eql([1,2,3,4])
  end
end
