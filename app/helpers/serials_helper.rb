module SerialsHelper
  SEASON_COLS_IN_ROW = 3
  
  def render_index_of_episodes(serial)
    output = []
    
    serial.seasons.all.in_groups_of(SEASON_COLS_IN_ROW, false).each_with_index do |row_seasons, row_index|
      row_counter = row_index+1

      output << render(:partial => "seasons_row", :locals => {
                         :row_counter => row_counter,
                         :row_seasons => row_seasons
                       })
    end

    output.join.html_safe
  end
end
