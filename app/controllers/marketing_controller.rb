class MarketingController < ApplicationController
  
  def index
    @page_title = 'Welcome!'
    end
  def about
    @page_title = 'About'
  end
  
  def faq
    @page_title = 'Frequently Asked Questions'
  end 
end
