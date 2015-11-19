module StaticPagesHelper

	def cache_key_for_all_notebooks
    	("all_notebooks/#{current_user.notebooks.maximum(:updated_at)}/")
  	end	
	def cache_key_for_notebook(notebook)
<<<<<<< HEAD
    	"notebook/#{notebook.id}/#{notebook.updated_at}/#{notebook.notes.count}"
=======
    	"notebook/#{notebook.id}/#{notebook.updated_at}"
>>>>>>> fb9ae3fdaa56b1ba7356bbdd9bb2780d2be4dee1
  	end

end
