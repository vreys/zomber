class EpisodesController < ApplicationController
  def show
    @serial = Serial.find_by_slug(params[:serial_id])
    @season = @serial.seasons.where(:index => params[:season_index]).first
    @episode = @season.episodes.where(:index => params[:episode_index]).first
  end
end
