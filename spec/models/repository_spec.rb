require 'spec_helper'

describe Repository, '#index!' do
  context "when repository directory is not empty" do
    before do
      @paths = []
      @containers = []
      
      3.times do
        container = Object.new
        path = SerialRepoFactory.create

        SerialContainer.stubs(:build).with(path).returns(container)
        
        @containers << container
        @paths << path
      end
    end
    
    it "should build container" do
      Serial.stubs(:rebuild)
      
      @paths.each do |path|
        SerialContainer.stubs(:build).with(path).once
      end

      Repository.index!
    end

    it "should rebuild Serial" do
      @containers.each do |container|
        Serial.stubs(:rebuild).with(container).once
      end

      Repository.index!
    end
  end

  context "when repository directory is empty" do
    it "should not change any Serial" do
      lambda { Repository.index! }.should_not change(Serial, :count)
    end
  end
end
