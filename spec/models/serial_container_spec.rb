require 'spec_helper'

describe SerialContainer do
  describe "#build" do
    context "when calling with path to an existant serial directory" do
      before do
        @path = SerialRepoFactory.create
        @meta = Object.new

        SerialMeta.stubs(:build).returns(@meta)
      end

      it "should build serial meta" do
        SerialMeta.stubs(:build).with(@path).once

        SerialContainer.build(@path)
      end

      it "should create new container instance with meta just builded" do
        SerialContainer.stubs(:new).with(:meta => @meta).once
        SerialContainer.build(@path)
      end

      it "should return new SerialContainer intance" do
        result = SerialContainer.build(@path)
        result.should be_an_instance_of(SerialContainer)
      end
    end

    context "when calling with path to a not existant serial directory" do
      before do
        @path = Rails.root.join('tmp', 'path', 'that', 'do', 'not', 'exists').to_s
      end

      it "should return nil" do
        result = SerialContainer.build(@path)
        result.should be_nil
      end
    end
  end

  describe "validations" do
    before do
      @valid_attributes = {
        :meta => SerialMetaFactory.create
      }
    end

    subject { SerialContainer.new(@valid_attributes) }

    it { should validate_presence_of(:meta) }
  end
end
