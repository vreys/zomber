# -*- coding: utf-8 -*-
def get_season_xpath(season_index)
  season_index = season_index.to_i

  row = 1
  col = season_index % SerialsHelper::SEASON_COLS_IN_ROW

  if col > 0
    row = (season_index - col) / SerialsHelper::SEASON_COLS_IN_ROW
    row += 1
  else
    row = season_index / SerialsHelper::SEASON_COLS_IN_ROW
    col = season_index / row
  end
  
  "//div[@id='serial_seasons']/div[@class='row'][#{row}]/ul[#{col}]/li[@class='season']"
end

def get_episode_xpath(season_index, episode_index)
  get_season_xpath(season_index) + "/ul/li[#{episode_index}]"
end

def within_season_xpath(season_index) 
  season_xpath = get_season_xpath(season_index)

  within(:xpath, season_xpath) do
    yield
  end
end

def within_episode_xpath(season_index, episode_index)
  episode_xpath = get_episode_xpath(season_index, episode_index)
  
  within(:xpath, episode_xpath) do
    yield
  end
end

Then /^я должен увидеть список сериалов$/ do
  page.should have_xpath('//div[@id="serials_grid"]')
end

Given /^есть такой сериал:$/ do |serial_options|
  When %Q{я захожу в раздел сериалов}
  When %Q{я прохожу по ссылке "Добавить сериал"}

  serial_meta    = []
  serial_seasons = []

  serial_options.raw.each do |options|
    if options[0] =~ /^(\d+) сезон$/
      serial_seasons << options
    else
      serial_meta << options
    end
  end

  serial_seasons.sort!{|x,y| x[0] <=> y[0]} unless serial_seasons.empty?
    
  serial_meta.each do |metas|
    meta_name, meta_value = *metas
    
    When %Q{я ввожу "#{meta_value}" в поле "#{meta_name}"}
  end

  When %Q{я нажимаю "Добавить сериал"}

  serial_seasons.each do |season|
    season_index   = season[0].match(/^(\d+)/)[1].to_i
    count_episodes = season[1].match(/^(\d+)/)[1].to_i
    
    When %Q{я прохожу по ссылке "Добавить #{season_index}-й сезон"}
    
    count_episodes.times.to_a.each do |i|
      episode_index = i+1

      episode_title = Faker::Lorem.words(3).join(" ")

      When %Q{я прохожу по ссылке "Добавить #{episode_index}-й эпизод" в #{season_index}-м сезоне}
      When %Q{я ввожу "#{episode_title}" в поле "Название на русском"}
      When %Q{я ввожу "#{episode_title}" в поле "Название на английском"}
      When %Q{я нажимаю "Добавить эпизод"}
    end
  end
end

Then /^я не должен увидеть список сериалов$/ do
  page.should have_no_css('#serials_grid')
end

Given /^есть (?:следующие|такие) сериалы:$/ do |serials|
  serials.hashes.each do |serial_fields|
    Given "есть такой сериал:", table(serial_fields.to_a)
  end
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

When /^я (?:перехожу|прохожу) по ссылке "([^\"]*)" (?:во|в) (\d+)\-м сезоне$/ do |link_text, season_index|
  within_season_xpath(season_index) do
    click_link(link_text)
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

Then /^я должен увидеть список эпизодов, состоящий из (\d+)\-го сезона$/ do |expected_seasons_count|
  all(:xpath, "//div[@id='serial_seasons']/div[@class='row']/ul/li[@class='season']").count.should eql(expected_seasons_count.to_i)
end

When /^я прохожу по ссылке "([^\"]*)" в (\d+)\-м эпизоде (\d+)\-го сезона$/ do |link, episode_index, season_index|
  within_episode_xpath(season_index, episode_index) do
    click_link(link)
  end
end

Then /^я должен увидеть ссылку "([^\"]*)" в (\d+)\-м эпизоде (\d+)\-го сезона$/ do |link, episode_index, season_index|
  within_episode_xpath(season_index, episode_index) do
    page.should have_link(link)
  end
end

Then /^я должен увидеть "([^\"]*)" в (\d+)\-м эпизоде (\d+)\-го сезона$/ do |text, episode_index, season_index|
  within_episode_xpath(season_index, episode_index) do
    page.should have_content(text)
  end
end

Then /^я должен увидеть в (\d+)\-м сезоне ссылку "([^\"]*)"$/ do |season_index, link_text|
  within_season_xpath(season_index) do
    page.should have_link(link_text)
  end
end

Then /^я должен увидеть такой список эпизодов:$/ do |seasons_table|
  seasons_table.raw.each do |season|
    season_title   = season[0]

    season_index   = season[0].match(/^(\d+)/)[1].to_i
    count_episodes = season[1].match(/^(\d+)/)[1].to_i

    last_episode_xpath = get_episode_xpath(season_index, count_episodes)

    within_season_xpath(season_title) do
      page.should have_content(season_title)
    end

    page.should have_xpath(last_episode_xpath)
  end
end
