class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:welcome_page]
  def home
  end
  def welcome_page
  	if user_signed_in?
  		redirect_to static_pages_home_path
  	end
  end
end
