class ApplicationController < ActionController::Base
  include UrlHelper
  
  protect_from_forgery

#  before_filter :authenticate_user!
end
