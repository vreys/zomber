require 'spec_helper'

describe SerialMeta do
  describe "#build" do
    before do
      @path = SerialRepoFactory.create
    end

    it "should read serial meta data" do
      SerialMeta.stubs(:read).with(@path).once
      SerialMeta.stubs(:new)
      SerialMeta.build(@path)
    end

    it "should create new meta instance with just readed data" do
      data = Object.new
      
      SerialMeta.stubs(:read).with(@path).returns(data)
      SerialMeta.stubs(:new).with(data).once
      SerialMeta.build(@path)
    end

    it "should return new meta instance" do
      result = SerialMeta.build(@path)
      result.should be_an_instance_of(SerialMeta)
    end
  end

  describe "#read" do
    before do
      @attrs = {
        :title => 'House M.D',
        :description => 'Lorem Ipsum dolar',
        :slug => 'house'
      }
      
      @path = SerialRepoFactory.create(@attrs)
      @poster = File.join(@path, 'poster.jpg').to_s
      @thumbnail = File.join(@path, 'thumbnail.jpg').to_s
    end

    it "should read serial description file" do
      result = SerialMeta.read(@path)
      result.delete(:poster)
      result.delete(:thumbnail)
      result.should eql(@attrs)
    end

    it "should read path to poster" do
      result = SerialMeta.read(@path)
      result[:poster].should eql(@poster)
    end

    it "should read path to thumbnail" do
      result = SerialMeta.read(@path)
      result[:thumbnail].should eql(@thumbnail)
    end
  end

  describe "validations" do
    subject { SerialMetaFactory.create }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:poster) }
    it { should validate_presence_of(:thumbnail) }
  end

  describe "attributes" do
    subject { SerialMetaFactory.create.attributes }

    it { subject.should include(:title) }
    it { subject.should include(:slug) }
    it { subject.should include(:description) }
    it { subject.should include(:poster) }
    it { subject.should include(:thumbnail) }

    describe :poster do
      subject { SerialMetaFactory.create.attributes[:poster] }

      it { should be_an_instance_of(File) }
    end

    describe :thumbnail do
      subject { SerialMetaFactory.create.attributes[:thumbnail] }

      it { should be_an_instance_of(File) }
    end
  end
end

