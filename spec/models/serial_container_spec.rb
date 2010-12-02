# -*- coding: utf-8 -*-
require 'spec_helper'

describe SerialContainer do
  context "after method new is called with path to serial repository" do
    before do
      attrs = {
        :title       => 'Доктор Хаус',
        :description => 'Сериал про мудака',
        :slug        => 'house',
        :alt_title   => 'House M.D'
      }

      @repo_path = RepositoryFactory(:serial, attrs)
      @expected_attributes = attrs
      @serial_container = SerialContainer.new(@repo_path)
    end

    it "should properly read meta into attributes" do
      @serial_container.attributes.should eql(@expected_attributes)
    end

    describe "poster" do
      subject { @serial_container.poster }
      
      it { should be_a(File) }
      
      it "should have proper path" do
        subject.path.should eql(@repo_path + '/poster.jpg')
      end
    end

    describe "thumbnail" do
      subject { @serial_container.thumbnail }
      
      it { should be_a(File) }
      
      it "should have proper path" do
        subject.path.should eql(@repo_path + '/thumbnail.jpg')
      end
    end

    describe "seasons" do
      before do
        @season_paths = []

        serial_repo_path = RepositoryFactory(:serial, :count_seasons => 0)
        
        5.times.to_a.each do |index|
          @season_paths << RepositoryFactory(:season,
                                             :serial_repo_path => serial_repo_path,
                                             :index => (index+1))
        end

        @serial_container = SerialContainer.new(serial_repo_path)
      end

      it "should create SeasonContainer for each directory in serial path" do
        @season_paths.each_with_index do |path, index|
          SeasonContainer.stubs(:new).with(:path => path, :index => (index+1)).once
        end

        @serial_container.seasons
      end

      it "should return array of SeasonContainers" do
        @serial_container.seasons.map{|s| s.class}.uniq.should eql([SeasonContainer])
      end
    end
  end
end
