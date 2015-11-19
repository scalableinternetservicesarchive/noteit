module StaticPagesHelper

	def cache_key_for_all_notebooks
    	("all_notebooks/#{current_user.notebooks.maximum(:updated_at)}/")
  	end	
	def cache_key_for_notebook(notebook)
    	"notebook/#{notebook.id}/#{notebook.updated_at}"
  	end

end
