module SerialsHelper
  def render_episodes_index(serial)
    season_groups = serial.seasons.all.in_groups_of(3, false)
    
    render :partial => "serials/seasons_row",
    :collection => season_groups, :as => :season_group
  end
end
