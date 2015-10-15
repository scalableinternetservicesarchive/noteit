class NotesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
  	 @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = "Nice one!"
      redirect_to root_url
    else
      flash[:alert] = "Oops!"
      redirect_to root_url
    end

  end

   private

    def note_params
      params.require(:note).permit(:title, :content)
    end
end
