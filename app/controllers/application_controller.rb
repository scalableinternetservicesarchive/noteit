class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #commenting out the following lines to remove 422 errors while testing
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
end
