require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@comment = Comment.new(content: "example comment")
	end

	test "should_be_valid" do
		assert @comment.valid?
	end

	test "content_should_be_present" do
		@comment.content = ""
		assert_not @comment.valid?
	end
end
