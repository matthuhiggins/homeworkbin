class MarketingController < ApplicationController
  layout 'playground'
  
  def index
    redirect_to_home if authenticated?
  end
end