class SerialsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [ :index ]
  
  def index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def show
    @serial = Serial.find_by_slug(params[:id])
  end
end
