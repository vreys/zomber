require 'spec_helper'

describe Serial do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }
  it { should have_many(:seasons, :dependent => :destroy) }
  
  # not working! WTF?
  #  it { should have_default_scope(:order => 'title ASC')}

  it { should have_attached_file(:poster) }
  it { should validate_attachment_presence(:poster) }

  it { should have_attached_file(:thumbnail) }
  it { should validate_attachment_presence(:thumbnail) }

  describe "#to_param" do
    subject { Factory(:serial) }

    it "should return slug attribute" do
      subject.to_param.should eql(subject.slug)
    end
  end

  describe "#import!" do
    before do
      @serial_container = ContainerFactory(:serial)
    end

    it "should create Serial with proper attributes" do
      lambda { Serial.import!(@serial_container) }.should change(Serial, :count).from(0).to(1)

      @serial = Serial.first
      
      @serial_container.attributes.each do |key, value|
        @serial[key] = value
      end
    end

    it "should import seasons" do
      @serial_container.seasons.each do |season_container|
        Season.stubs(:import!).with(season_container).once
      end

      Serial.import!(@serial_container)
    end
  end
end
