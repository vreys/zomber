require 'spec_helper'

describe Repository, '#index!' do
  before do
    @serial_containers = []
    @paths = []

    3.times do
      path = RepositoryFactory(:serial)

      @serial_containers << ContainerFactory(:serial, path)
      @paths << path
    end
  end

  it "should destroy all Serials" do
    Serial.stubs(:destroy_all).once

    Repository.index!
  end

  it "should import Serials" do
    @serial_containers.each_with_index do |serial_container, index|
      path = @paths[index]
      
      SerialContainer.stubs(:new).with(path).returns(serial_container).once
      Serial.stubs(:import!).with(serial_container).once
    end

    Repository.index!
  end
end
