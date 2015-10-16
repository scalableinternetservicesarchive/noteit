require 'test_helper'

class NoteTest < ActiveSupport::TestCase
	def setup
		@user = users(:testUser)
		@note = Note.new(title: "Example note", content: "example.pdf", user_id: @user.id)
	end

	test "should be valid" do 
		assert @note.valid?
	end

	test "user id should be present" do
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end
end
