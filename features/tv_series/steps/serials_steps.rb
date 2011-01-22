# -*- coding: utf-8 -*-
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

  serial_meta = Hash[*serial_meta.flatten]
  
  serial_meta = {
    "Название на английском" => Russian.transliterate(serial_meta["Название на русском"]),
    "Описание"               => Faker::Lorem.sentences(8).join(" ")
  }.merge(serial_meta).to_a
  
  serial_meta.each do |metas|
    meta_name, meta_value = *metas
    
    When %Q{я ввожу "#{meta_value}" в поле "#{meta_name}"}
  end

  When %Q{я нажимаю "Добавить сериал"}

  serial_seasons.each do |season|
    season_index   = season[0].match(/^(\d+)/)[1].to_i
    count_episodes = season[1].match(/^(\d+)/)[1].to_i
    
    When %Q{я нажимаю кнопку "Добавить #{season_index}-й сезон"}
    
    count_episodes.times.to_a.each do |i|
      episode_index = i+1

      episode_title = Faker::Lorem.words(3).join(" ")

      When %Q{я нажимаю кнопку "Добавить #{episode_index}-й эпизод" в #{season_index}-м сезоне}
      When %Q{я ввожу "#{episode_title}" в поле "Название на русском"}
      When %Q{я ввожу "#{episode_title}" в поле "Название на английском"}
      When %Q{я нажимаю "Добавить эпизод"}
    end
  end
end

Given /^есть сериал "([^\"]*)"$/ do |serial_title|
  serial_fields = {
    "Название на русском"    => serial_title,
    "Название на английском" => Russian.transliterate(serial_title),
    "Описание"               => Faker::Lorem.sentences(8).join(" ")
  }

  Given "есть такой сериал:", table(serial_fields.to_a)
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

Given /^я на странице сериала "([^\"]*)"$/ do |serial_title|
  When %Q{я захожу на страницу сериала "#{serial_title}"}
end

When /^я захожу на страницу сериала "([^\"]*)"$/ do |serial_title|
  When %Q{я захожу в раздел сериалов}
  When %Q{я иду по ссылке "#{serial_title}"}
end
