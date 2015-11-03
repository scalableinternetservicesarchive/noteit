class NotebooksController < ApplicationController
	before_action :authenticate_user!
	def show
		@notebook = Notebook.find(params[:id])
		@notes = @notebook.notes
    	if(user_signed_in?)
     	 	@note_owner = @notebook.user_id
    	else
      		@note_owner = -1
    	end
	end

	def create
		@notebook = current_user.notebooks.build(notebook_params)
		if @notebook.save
			flash[:success] = "Notebook created"
		else
			flash[:alert] = "Sorry, we experienced an error"
		end
		redirect_to static_pages_home_path
	end

	private

    	def notebook_params
      		params.require(:notebook).permit(:title)
    	end
    
end
