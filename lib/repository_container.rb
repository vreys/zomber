module RepositoryContainer
  class Base
    class_attribute :attribute_names

    class << self
      def attributes(*attrs)
        self.attribute_names = attrs || []

        attrs.each do |attr|
       #   self.send('attr_reader', attr)
        end
      end
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def attributes
      attrs = {}
      
      attribute_names.each do |attr_name|
        attrs[attr_name] = read_attribute(attr_name)
      end

      attrs
    end

    def read_attribute(name)
      @attributes[name]
    end

    def [](name)
      read_attribute(name)
    end
  end
end
