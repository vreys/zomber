require "spec_helper"

describe Season, "#decrease_index_number!" do
  before do
    @serial = Factory(:serial)
  end
  
  context "when Season#index_number = 1" do
    subject { @serial.seasons.create }

    it "should not change :index_number" do
      lambda { subject.decrease_index_number! }.should_not change(subject, :index_number)
    end
  end

  context "when Season#index_number != 1" do
    before do
      5.times{ @serial.seasons.create }

      @subject = @serial.seasons.fourth
      @target  = @serial.seasons.third
    end

    it "should decrease by 1 :index_number" do
      lambda{ @subject.decrease_index_number! }.should change(@subject, :index_number).by(-1)
      @subject.should_not be_changed
    end

    it "should increase by 1 :index_number of the previous Season" do
      lambda{ @subject.decrease_index_number! }.should change(@target, :index_number).by(1)
      @target.should_not be_changed
    end
  end
end
