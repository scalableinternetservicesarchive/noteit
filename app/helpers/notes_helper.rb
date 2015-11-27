module NotesHelper

	def cache_key_for_all_notes
    	"all_notes/#{current_user.notes.maximum(:updated_at)}"
  	end	
	def cache_key_for_note(note)
    	"note/#{note.id}/#{note.updated_at}"
  	end

def cache_key_for_search_note(keyword, note)
      "note/#{keyword}/#{note.id}/#{note.updated_at}"
 end


  	def cache_key_for_all_comments(comments)
  		"all_comments/#{comments.maximum(:updated_at)}"
  	end
  	def cache_key_for_comment(comment)
  		"comment/#{comment.id}/#{comment.updated_at}"	
  	end

    def cache_key_for_search(keyword, notes)
      "search/#{keyword}/#{notes.maximum(:updated_at)}"
    end
end
