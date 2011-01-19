require 'spec_helper'

describe Serial do
  context "after save" do
    it "should have permalink as parameterized original_title" do
      serial = Factory(:serial, :original_title => 'House M.D.')

      serial.permalink.should eql(serial.original_title.parameterize)
    end
  end
end
