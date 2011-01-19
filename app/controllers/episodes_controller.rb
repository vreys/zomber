# -*- coding: utf-8 -*-
class EpisodesController < ApplicationController
  before_filter :define_parent_resources
  before_filter :build_episode_resource, :only => [:new, :create]
  before_filter :define_episode_resource, :except => [:new, :create]
  before_filter :update_episode_attributes, :only => [:create, :update]
  
  def create
    flash[:success] = "Добавлен #{@season.index}-й эпизод в #{@season.index}-й сезон"

    redirect_to_serial_page
  end

  def edit
    # if this method delete (as new method deleted, but view is exists),
    # then cucumber somehow calls new action, instead edit
  end

  def update
    flash[:success] = "#{@episode.index}-й эпизод в #{@season.index}-м сезоне обнавлен"

    redirect_to_serial_page
  end

  def destroy
    episode_title = @episode.title

    @episode.destroy

    flash[:success] = "Эпизод «#{episode_title}» удален"

    redirect_to_serial_page
  end

  protected

  def define_parent_resources
    @serial = Serial.find_by_permalink(params[:serial_id])
    @season = @serial.seasons.find_by_index(params[:season_id])
  end

  def build_episode_resource
    @episode = @season.episodes.build
  end

  def define_episode_resource
    @episode = @season.episodes.find_by_index(params[:id])
  end

  def update_episode_attributes
    @episode.update_attributes(params[:episode])

    # ensure that episode is appended to season
    @season.save!
  end

  def redirect_to_serial_page
    redirect_to serial_path(@serial)
  end
end
