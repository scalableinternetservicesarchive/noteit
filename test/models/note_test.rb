require 'test_helper'

class NoteTest < ActiveSupport::TestCase
	def setup
		@note = Note.new(title: "Example note", content: "note content")
	end

	test "should_be_valid" do
		assert @note.valid?
	end
	
	test "title_should_be_present" do
		@note.title = "   "
		assert_not @note.valid?
	end

	test "content_should_be_present" do
		@note.content = ""
		assert_not @note.valid?
	end

	test "title_should_not_be_too_long" do
		@note.title = "a" * 61
		assert_not @note.valid?
	end
end
