require 'spec_helper'

describe Serial do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }
  it { should have_attached_file(:poster) }
  it { should validate_attachment_presence(:poster) }

  describe "#to_param" do
    before do
      @serial = Factory(:serial)
    end

    it "should return slug attribute" do
      @serial.to_param.should eql(@serial.slug)
    end
  end
end
