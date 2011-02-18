class SerialsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def show
    @serial = Serial.find_by_slug(params[:id])
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
end
