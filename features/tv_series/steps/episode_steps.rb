# -*- coding: utf-8 -*-
Then /^я должен увидеть список серий для (\d+) (?:сезонов|сезона)$/ do |count_seasons|
  (1..count_seasons.to_i).to_a.each do |index|
    page.should have_content("#{index} сезон")
  end
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

Then /^я должен увидеть список эпизодов, состоящий из (\d+)\-(?:го|х) сезона$/ do |expected_seasons_count|
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
