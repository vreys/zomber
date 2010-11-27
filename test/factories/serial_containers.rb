module SerialContainerFactory
  def self.create(attrs = {})
    attrs = attrs.merge({:meta => SerialMetaFactory.create})

    SerialContainer.new(attrs)
  end
end
