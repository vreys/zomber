# -*- coding: utf-8 -*-
Given /^есть (\d+) разных сериалов$/ do |count_serials|
  count_serials.to_i.times { SerialRepoFactory.create }

  Repository.index!
end

Then /^я должен увидеть список из (\d+) сериалов$/ do |count_serials|
  all('#serials_list li').count.should eql(count_serials.to_i)
end

Given /^есть сериал "([^\"]*)"$/ do |serial_title|
  SerialRepoFactory.create(:title => serial_title)
  
  Repository.index!
end

Then /^я не должен увидеть список сериалов$/ do
  page.should have_no_css('#serials_list')
end

Given /^есть (?:следующие|такие) сериалы:$/ do |serials|
  KEY_ALIASES = {'название' => :title, 'описание' => :description, 'количество сезонов' => :count_seasons}

  serials.hashes.each do |options|
    attrs = {}

    options.each do |key, value|
      attrs[KEY_ALIASES[key]] = value
    end

    SerialRepoFactory.create(attrs)
  end

  Repository.index!
end

When /^я захожу на страницу сериала "([^\"]*)"$/ do |serial_title|
  When %Q{я захожу в раздел сериалов}
  When %Q{я иду по ссылке "#{serial_title}"}
end

Then /^я должен увидеть постер$/ do
  page.should have_css('#poster.serial[src^="/images/posters"]')
end

Then /^я должен увидеть список серий для (\d+) (?:сезонов|сезона)$/ do |count_seasons|
  (1..count_seasons.to_i).to_a.each do |index|
    page.should have_content("#{index} сезон")
  end
end

Given /^есть такой сериал:$/ do |table|
  KEY_ALIASES = {'название' => :title, 'описание' => :description, 'количество сезонов' => :count_seasons}
  COUNT_EPISODES = /(\d+) (?:эпизод(?:а|ов)|cери(?:я|и|й))/i
  
  attrs = {}
  seasons = []
  
  table.raw.each do |options|
    unless (options[0] =~ /(\d+) сезон/).nil?
      seasons.push((options[1].match(/^(\d+)(?:.+)/)[1]).to_i)
    else
      attrs[KEY_ALIASES[options[0]]] = options[1]
    end
  end

  if seasons.length > 0
    attrs[:count_seasons] = 0
  end

  serial_path = SerialRepoFactory.create(attrs)

  seasons.each_with_index do |count_episodes, season_index|
    SeasonRepoFactory.create(serial_path, season_index, count_episodes)
  end
  
  Repository.index!
end

Then /^я должен увидеть такой список сезонов:$/ do |table|
  table.raw.each do |options|
    season_index = options[0].match(/^(\d+).+/)[1].to_i
    count_episodes = options[1].match(/^(\d+).+/)[1].to_i

    page.should have_content("#{season_index} сезон")

    (1..count_episodes).to_a.each do |episode_index|
      page.should have_content("#{episode_index} эпизод")
    end
  end
end
