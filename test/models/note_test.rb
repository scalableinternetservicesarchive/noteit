require 'test_helper'

class NoteTest < ActiveSupport::TestCase
	def setup
		@note = Note.new(title: "Example note", content: "example.pdf")
	end

	test "should be valid" do 
		assert @note.valid?
	end
end
