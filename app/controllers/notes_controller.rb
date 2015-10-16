class NotesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
	puts "NOTE CREATION" 
	@note = current_user.notes.build(note_params)
    if @note.save
		puts "NOTE SAVED"
	   	flash[:success] = "Nice one!"
    else
		puts "ERROR: NOTE NOT SAVED"
      	flash[:alert] = "Oops!"
    end
    redirect_to root_url
    return
  end

   private

    def note_params
      params.require(:note).permit(:title, :content)
    end
end
