class SerialsController < ApplicationController
  def index

  end

  def show
    @serial = Serial.find_by_slug(params[:id])
  end
end
