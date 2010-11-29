# -*- coding: utf-8 -*-
SERIAL_KEY_ALIASES = {'название' => :title, 'описание' => :description, 'количество сезонов' => :count_seasons}

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
  serials.hashes.each do |options|
    attrs = {}

    options.each do |key, value|
      attrs[SERIAL_KEY_ALIASES[key]] = value
    end

    SerialRepoFactory.create(attrs)
  end

  Repository.index!
end

Then /^я должен увидеть список сериалов в таком порядке:$/ do |serials_table|
  serials_table.raw.each_with_index do |opts, index|
    find(:xpath, "//ul[@id='serials_list']/li[#{(index+1)}]/a").text.should eql(opts[0])
  end
end

Then /^я должен увидеть (\d+) иконок$/ do |count_icons|
  all('img.thumb[src^="/images/thumbnails"]').length.should eql(count_icons.to_i)
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
  attrs = {}
  seasons = []
  
  table.raw.each do |options|
    unless (options[0] =~ /(\d+) сезон/).nil?
      seasons.push((options[1].match(/^(\d+)(?:.+)/)[1]).to_i)
    else
      attrs[SERIAL_KEY_ALIASES[options[0]]] = options[1]
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

When /^я перехожу по ссылке "([^\"]*)" во (\d+) сезоне$/ do |episode, season_index|
  within(:xpath, "//div[@id='serial-seasons']/ul[#{season_index}]/li") do
    click_link(episode)
  end
end

Then /^я должен увидеть проигрыватель$/ do
  page.should have_css('#player')
end
