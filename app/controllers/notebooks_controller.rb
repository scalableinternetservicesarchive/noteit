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
end
