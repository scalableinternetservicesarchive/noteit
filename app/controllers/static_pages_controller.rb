class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:welcome_page]

  def home
    #@notes = current_user.notes.paginate(page: params[:page])
    @notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
  end

  def welcome_page
  	if user_signed_in?
  		redirect_to static_pages_home_path
  	end
  end

end
