class MarketingController < ApplicationController
  layout 'playground'
  
  def index
    redirect_after_login if authenticated?
  end
end