# -*- coding: utf-8 -*-
class SeasonsController < ApplicationController
  def new
    serial = Serial.find_by_permalink(params[:serial_id])
    serial.seasons.create
    serial.save!

    flash[:success] = "#{serial.seasons.count}-й сезон добавлен"

    redirect_to serial_path(serial)
  end

  def destroy
    @serial = Serial.find_by_permalink(params[:serial_id])
    @season = @serial.seasons.find_by_index(params[:id])

    @season.destroy

    flash[:success] = "Сезон удален"

    redirect_to serial_path(@serial)
  end
end
