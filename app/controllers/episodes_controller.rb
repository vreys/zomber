# -*- coding: utf-8 -*-
class EpisodesController < ApplicationController
  before_filter :define_resources
  
  def new
    @episode = @season.episodes.build
  end

  def create
    @episode = @season.episodes.create(params[:episode])
    @episode.save!

    @season.episodes << @episode
    @season.save!

    flash[:success] = "Добавлен #{@season.index}-й эпизод в #{@season.index}-й сезон"

    redirect_to serial_path(@serial)
  end

  protected

  def define_resources
    @serial = Serial.find_by_permalink(params[:serial_id])
    @season = @serial.seasons.find_by_index(params[:season_id])    
  end
end
