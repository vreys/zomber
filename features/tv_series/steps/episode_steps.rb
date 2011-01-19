# -*- coding: utf-8 -*-
Then /^я должен увидеть список серий для (\d+) (?:сезонов|сезона)$/ do |count_seasons|
  (1..count_seasons.to_i).to_a.each do |index|
    page.should have_content("#{index} сезон")
  end
end

Given /^(\d+)\-й сезон сериала "([^\"]*)" состоит из таких эпизодов:$/ do |season_index, serial_title, episodes|
  When %Q{я захожу на страницу сериала "#{serial_title}"}
  When %Q{я прохожу по ссылке "Добавить #{season_index}-й сезон"}

  episodes.hashes.each_with_index do |episode, index|
    When %Q{я добавляю #{index+1}-й эпизод #{season_index}-го сезона с таким содержанием:}, table(episode.to_a)
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

When /^я прохожу по ссылке "([^\"]*)" (?:в|во) (\d+)\-м эпизоде (\d+)\-го сезона$/ do |link, episode_index, season_index|
  within_episode_xpath(season_index, episode_index) do
    click_link(link)
  end
end

When /^я нажимаю кнопку "([^\"]*)" во (\d+)\-м эпизоде (\d+)\-го сезона$/ do |button, episode_index, season_index|
  within_episode_xpath(season_index, episode_index) do
    click_button(button)
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

When /^я добавляю (\d+)\-й эпизод (\d+)\-го сезона с таким содержанием:$/ do |episode_index, season_index, fields|
  When %Q{я прохожу по ссылке "Добавить #{episode_index}-й эпизод" в #{season_index}-м сезоне}

  Hash[*fields.raw.flatten].each_pair do |field_label, field_value|
    When %Q{я ввожу "#{field_value}" в поле "#{field_label}"}
  end

  When %Q{я нажимаю "Добавить эпизод"}
end

Then /^я должен увидеть (\d+) эпизодов в (\d+)\-м сезоне$/ do |count_episodes, season_index|
  count_episodes_in_season(season_index).should eql(count_episodes.to_i)
end

Then /^я должен увидеть такой список эпизодов (\d+)\-го сезона:$/ do |season_index, episodes|
  Then %Q{я должен увидеть #{episodes.hashes.count} эпизодов в #{season_index}-м сезоне}
    
  episodes.hashes.each_with_index do |episode_values, index|
    episode_index = index + 1

    episode_values.each_pair do |key, value|
      step_clause = %Q{в #{episode_index}-м эпизоде #{season_index}-го сезона}
        
      case key.downcase
      when "название на русском"
        step = %Q{я должен увидеть ссылку "#{value}" } + step_clause
      else
        step = %Q{я должен увидеть "#{value}" } + step_clause
      end

      Then step
    end
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
