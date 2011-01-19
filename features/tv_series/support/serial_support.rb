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
