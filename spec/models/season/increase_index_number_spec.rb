require "spec_helper"

describe Season, "#increase_index_number!" do
  before do
    @serial = Factory(:serial)

    no_more_than(8).upto(16).to_a.each do
      @serial.seasons.create
    end
  end

  context "when Season#last? is true" do
    subject{ @serial.seasons.last }

    it "should not change :index_number" do
      lambda{ subject.increase_index_number! }.should_not change(subject, :index_number)
    end
  end

  context "when Season#last? is false" do
    before do
      @subject = @serial.seasons.third
      @target  = @serial.seasons.fourth
    end

    subject{ @subject.increase_index_number! }

    it "should change :index_number by 1" do
      lambda{ subject }.should change(@subject, :index_number).by(1)
      @subject.should_not be_changed
    end

    it "should change :index_number of next Season by -1" do
      lambda{ subject }.should change(@target, :index_number).by(-1)
      @target.should_not be_changed
    end
  end
end
