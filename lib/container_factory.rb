class ContainerFactory
  class << self
    attr_accessor :factories
    
    def define(name, &block)
      self.factories[name] = block
    end
    
    def create(name, *args)
      factory = self.factories[name] || raise("Unknown container factory: #{name}")
      klass = "#{name}_container".classify.constantize
      
      *args = factory.call(*args)

      klass.new(*args)
    end
  end

  self.factories = {}
end

def ContainerFactory(name, *args)
  ContainerFactory.create(name, *args)
end
