ContainerFactory.define(:serial) do |*args|
  path = args[0] || RepositoryFactory(:serial)
end

ContainerFactory.define(:season) do |*args|
  attrs = args[0]
  
  index = (attrs.nil? || attrs[:index].nil?) ?
  (rand(8)+2) :
    attrs[:index]
  
  path = (attrs.nil? || attrs[:path].nil?) ?
  RepositoryFactory(:season, :index => index) :
    attrs[:path]

  {
    :index => index,
    :path => path
  }
end

ContainerFactory.define(:episode) do |*args|
  attrs = {
    :index => (rand(11)+3)
  }.merge(args[0] || {})

  RepositoryFactory(:episode, :index => attrs[:index]).merge(attrs)
end
