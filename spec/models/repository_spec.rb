require 'spec_helper'

describe Repository, '#index!' do
  before do
    @titles = []
    @slugs = []
    
    10.times do
      title = Faker::Lorem.words(rand(4)+1).join(' ')
      slug = Faker::Lorem.words(rand(3)+2).join('-')
      
      SerialRepoFactory.create(title, slug)

      @slugs << slug
      @titles << title
    end
  end

  after do
    serial_repos_path = Rails.root.join('tmp', 'serials')
    
    FileUtils.rm_r(serial_repos_path) if File.exists?(serial_repos_path)
  end

  it "should create Serial for each directory in serials repo" do
    lambda { Repository.index! }.should change(Serial, :count).from(0).to(10)
  end

  it "should read title from meta file for each serial repo" do
    Repository.index!
    Serial.all.map{|s| s.title}.to_set.should eql(@titles.to_set)
  end

  it "should read slug from meta file for each serial repo" do
    Repository.index!
    Serial.all.map{|s| s.slug}.to_set.should eql(@slugs.to_set)
  end
end
