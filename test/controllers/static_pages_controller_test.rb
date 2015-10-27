require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
	
	#test "should get home" do
    #	get :home
    #	assert_response :success
  	#end

  	test "should get welcome page" do
    	get :welcome_page
    	assert_response :success
    	assert_select "title", "Welcome | NoteIt"
  	end
end
