# -*- coding: utf-8 -*-
class SeasonsController < ApplicationController
  before_filter :define_serial_resource
  before_filter :define_season_resource, :except => [:new]
  
  def new
    @serial.seasons.create
    @serial.save

    flash[:success] = "#{@serial.seasons.last.index_number}-й сезон добавлен"

    redirect_to_serial_page and return
  end

  def destroy
    @season.destroy

    flash[:success] = "Сезон удален"

    redirect_to_serial_page and return
  end

  def down
    @season.decrease_index_number!
    
    flash[:success] = "#{@season.next.index_number}-й и #{@season.index_number}-й сезоны поменяны местами"
    
    redirect_to_serial_page and return
  end

  protected

  def define_serial_resource
    @serial = Serial.find_by_permalink(params[:serial_id])
  end

  def define_season_resource
    @season = @serial.seasons.find_by_index_number(params[:id])
  end

  def redirect_to_serial_page
    redirect_to serial_path(@serial)
  end
end
