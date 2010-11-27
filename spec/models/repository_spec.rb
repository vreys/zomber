require 'spec_helper'

describe Repository, '#index!' do
  before do
    @titles = []
    @slugs = []
    @descriptions = []
    
    3.times do
      title = Faker::Lorem.words(rand(4)+1).join(' ')
      slug = Faker::Lorem.words(rand(3)+2).join('-')
      desc = Faker::Lorem.words(rand(10)+4).join(' ')
      
      SerialRepoFactory.create(:title => title, :slug => slug, :description => desc)

      @slugs << slug
      @titles << title
      @descriptions << desc
    end
  end

  it "should create Serial for each directory in serials repo" do
    lambda { Repository.index! }.should change(Serial, :count).from(0).to(3)
  end

  it "should read title from meta file for each serial repo" do
    Repository.index!
    Serial.all.map{|s| s.title}.to_set.should eql(@titles.to_set)
  end

  it "should read slug from meta file for each serial repo" do
    Repository.index!
    Serial.all.map{|s| s.slug}.to_set.should eql(@slugs.to_set)
  end

  it "should read description from meta file for each serials repo" do
    Repository.index!
    Serial.all.map{|s| s.description}.to_set.should eql(@descriptions.to_set)
  end
end
