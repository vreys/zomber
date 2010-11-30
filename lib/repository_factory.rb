class RepositoryFactory
  class << self
    attr_accessor :factories

    def define(name, &block)
      self.factories[name] = block
    end

    def call(name, attrs)
      factory = @factories[name] || raise("Unknown repository factory: #{name}")
      factory.call(attrs)
    end
  end

  self.factories = {}
end

def RepositoryFactory(name, attrs = {})
  RepositoryFactory.call(name, attrs)
end
