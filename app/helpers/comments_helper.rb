module CommentsHelper

def cache_key_for_all_comments(comments)
  		"all_comments/#{comments.maximum(:updated_at)}"
  	end
def cache_key_for_comment(comment)
 	"comment/#{comment.id}/#{comment.updated_at}"	
end

end
