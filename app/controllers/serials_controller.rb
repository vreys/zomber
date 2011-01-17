# -*- coding: utf-8 -*-
class SerialsController < ApplicationController
#  skip_before_filter :authenticate_user!, :only => [ :index ]
  
  def index
#    redirect_to new_user_session_path unless user_signed_in?
  end

  def new
    
  end

  def create
    @serial = Serial.create!(params[:serial])

    flash[:success] = "Сериал «#{@serial.title}» добавлен"
    redirect_to serial_path(@serial)
  end

  def show
    @serial = Serial.find_by_permalink(params[:id])
  end
end
