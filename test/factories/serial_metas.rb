module SerialMetaFactory
  def self.create
    attrs = {
      :title => Faker::Lorem.words(rand(6)+2).join(' '),
      :slug => Faker::Lorem.words(rand(4)+2).join('-'),
      :description => Faker::Lorem.words(rand(6)+2).join(' '),
      :poster => Rails.root.join('test', 'factories', 'poster.jpg').to_s,
      :thumbnail => Rails.root.join('test', 'factories', 'thumbnail.jpg').to_s
    }

    SerialMeta.new(attrs)
  end
end
