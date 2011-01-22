# -*- coding: utf-8 -*-
module SerialsHelper
  SEASON_COLS_IN_ROW = 2
  
  def render_index_of_episodes(serial)
    output = []

    serial.seasons.ascending(:index_number).in_groups_of(SEASON_COLS_IN_ROW, false).each_with_index do |row_seasons, row_index|
      row_counter = row_index+1

      output << render(:partial => "seasons_row", :locals => {
                         :row_counter => row_counter,
                         :row_seasons => row_seasons
                       })
    end

    output.join.html_safe
  end

  def render_new_episode_in_season_button(season)
    text = "Добавить #{season.episodes.count+1}-й эпизод"
    url  = new_serial_season_episode_path(season.serial, season)
    
    button_to(text, url, :method => :get)
  end

  def render_new_season_button(serial)
    text = "Добавить #{serial.seasons.count+1}-й сезон"
    url  = new_serial_season_path(@serial)
    
    button_to(text, url, :method => :get)
  end

  def render_destroy_season_button(season)
    text = "удалить сезон"
    url  = serial_season_path(season.serial, season)

    button_to(text, url, :method => :delete)
  end

  def render_season_down_button(season)
    text = "Сделать #{season.index_number-1}-м сезоном"
    id   = "season_#{season.index_number}_down_button"
    url  = down_serial_season_path(season.serial, season)

    button_to("down", url, :id => id, :method => :put)
  end
end
