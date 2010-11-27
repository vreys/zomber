require 'spec_helper'

describe SerialMeta do
  describe "#build" do
    before do
      @path = SerialRepoFactory.create
      @data = {
        :title => 'House M.D',
        :slug => 'house',
        :description => 'Lorem ipsum',
        :poster => Rails.root.join('test', 'factories', 'poster.jpg') }
      
      SerialMeta.stubs(:read).with(@path).returns(@data)
    end

    it "should read serial meta data" do
      SerialMeta.stubs(:read).with(@path).returns(@data).once
      SerialMeta.build(@path)
    end

    it "should create new meta instance with just readed data" do
      SerialMeta.stubs(:new).with(@data).once
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
    end

    it "should read serial description file" do
      result = SerialMeta.read(@path)
      result.delete(:poster)
      result.should eql(@attrs)
    end

    it "should read path to poster" do
      result = SerialMeta.read(@path)
      result[:poster].should eql(@poster)
    end
  end

  describe "validations" do
    before do
      @valid_attributes = {
        :title => 'House M.D',
        :slug => 'house',
        :description => 'Lorem ipsum',
        :poster => Rails.root.join('test', 'factories', 'poster.jpg').to_s
      }
    end

    subject { SerialMeta.new(@valid_attributes) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:poster) }
  end
end

