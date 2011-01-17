require 'spec_helper'

describe Serial do
  context "after save" do
    it "should have id as parameterized original_title" do
      serial = Factory(:serial, :original_title => 'House M.D.')

      serial.id.should eql(serial.title.parameterize)
    end
  end
end
