class RepositoryController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [ :send_video ]

  def send_video
    head(:status => :forbidden) and return unless user_signed_in?

    @serial  = Serial.find_by_slug(params[:serial_slug])
    @season  = @serial.seasons.find_by_index(params[:season_index]) if @serial
    @episode = @season.episodes.find_by_index(params[:episode_index]) if @season

    head(:status => :not_found) and return if [@serial, @season, @episode].map(&:nil?).include?(true)

    path = @episode.send(params[:format])
    mime = Mime.const_get(params[:format].to_s.upcase)

    head(:x_accel_redirect => File.join('/stream', path))
  end
end
