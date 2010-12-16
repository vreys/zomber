# -*- coding: utf-8 -*-
SERIAL_KEY_ALIASES = {
  'название' => :title,
  'описание' => :description,
  'количество сезонов' => :count_seasons,
  'альтернативное название' => :alt_title,
  'оригинальное название' => :alt_title
}

Given /^есть (\d+) разных сериалов$/ do |count_serials|
  count_serials.to_i.times { RepositoryFactory(:serial) }

  Repository.index!
end

Then /^я должен увидеть список сериалов$/ do
  page.should have_xpath('//div[@id="serials_grid"]')
end

Then /^я должен увидеть список из (\d+) сериалов$/ do |count_serials|
  all('#serials_grid li').count.should eql(count_serials.to_i)
end

Given /^есть сериал "([^\"]*)"$/ do |serial_title|
  RepositoryFactory(:serial, :title => serial_title)
  
  Repository.index!
end

Then /^я не должен увидеть список сериалов$/ do
  page.should have_no_css('#serials_grid')
end

Given /^есть (?:следующие|такие) сериалы:$/ do |serials|
  serials.hashes.each do |options|
    attrs = {}

    options.each do |key, value|
      attrs[SERIAL_KEY_ALIASES[key]] = value
    end

    RepositoryFactory(:serial, attrs)
  end

  Repository.index!
end

Then /^я должен увидеть список сериалов в таком порядке:$/ do |serials_table|
  list = []
  
  all(:xpath, "//div[@id='serials_grid']/ul/li/a/strong").each do |el|
     list << el.text.strip
  end
  
  serials_table.raw.to_a.flatten.should eql(list)
end

Then /^я должен увидеть (\d+) иконок$/ do |count_icons|
  all(:xpath, "//div[@id='serials_grid']/ul/li/a/img").map do |img|
    img['src'].should match(/^\/images\/thumbnails\/(?:\d+)\/thumbnail_default\.jpg/)
  end.length.should eql(count_icons.to_i)
end

When /^я захожу на страницу сериала "([^\"]*)"$/ do |serial_title|
  When %Q{я захожу в раздел сериалов}
  When %Q{я иду по ссылке "#{serial_title}"}
end

Then /^я должен увидеть постер$/ do
  find(:xpath, "//div[@id='serial_seasons']")['style'].should match(/\/images\/posters\/(?:\d+)\/poster_default\.jpg/)
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

  serial_path = RepositoryFactory(:serial, attrs)

  seasons.each_with_index do |count_episodes, season_index|
    RepositoryFactory(:season,
                      :serial_repo_path => serial_path,
                      :index => season_index,
                      :count_episodes => count_episodes)
  end
  
  Repository.index!
end

Then /^я должен увидеть список эпизодов$/ do
  page.should have_xpath("//div[@id='serial_seasons']")
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

When /^я перехожу по ссылке "([^\"]*)" (?:во|в) (\d+) сезоне$/ do |episode, season_index|
  season_index = season_index.to_i

  row = 1
  col = 1

  if season_index%3 > 0
    col = season_index%3
    row = (season_index-col)/3
    row = 1 if row < 1
  else
    row = season_index/3
  end
  
  within(:xpath, "//div[@id='serial_seasons']/div[#{row}]/ul[#{col}]/li") do
    click_link(episode)
  end
end

When /^я захожу на страницу (\d+) эпизода (?:во|в) (\d+) сезоне сериала "([^\"]*)"$/ do |episode_index, season_index, serial_title|
  When %Q{я захожу на страницу сериала "#{serial_title}"}
  When %Q{я перехожу по ссылке "#{episode_index} эпизод" во #{season_index} сезоне}
end

Then /^я должен увидеть проигрыватель$/ do
  sources = []
  
  all(:xpath, "//video/source").each do |source|
     sources << source['src'].match(/.(mp4|webm|m3u8)$/i)[1]
  end

  sources.should include('mp4', 'webm', 'm3u8')
end

Then /^я должен быть на странице сериала "([^\"]*)"$/ do |serial_title|
  Then %Q{я должен увидеть "#{serial_title}"}
  Then %Q{я должен увидеть список эпизодов}
end

Then /^я должен (?:быть|оказаться) на странице (\d+) эпизода (?:в|во) (\d+) сезоне сериала "([^\"]*)"$/ do |episode_index, season_index, serial_title|
  Then %Q{я должен увидеть "#{serial_title}"}
  Then %Q{я должен увидеть "#{episode_index} эпизод"}
  Then %Q{я должен увидеть "#{season_index} сезон"}
  Then %Q{я должен увидеть проигрыватель}
end
