class NotebooksController < ApplicationController
	before_action :authenticate_user!
	def show
		#@notebooks = current_user.notebooks 
		@notebook = Notebook.find(params[:id])
		@notes = @notebook.notes if stale?(@notebook.notes.all)
    	if(user_signed_in?)
     	 	@note_owner = @notebook.user_id
    	else
      		@note_owner = -1
    	end
	end

	def delete
		flash[:success] = "Notebook deleted"
	end


	def create
		@notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
		@notebook = current_user.notebooks.build(notebook_params)
		if @notebook.save
			flash[:success] = "Notebook created"
		else
			flash[:alert] = "Please make sure of the Notebook title."
		end
		redirect_to static_pages_home_path
	end

	private

    	def notebook_params
      		params.require(:notebook).permit(:title)
    	end
    
end
