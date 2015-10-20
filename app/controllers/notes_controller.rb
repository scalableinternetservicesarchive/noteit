class NotesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
  	 @note = current_user.notes.build(note_params)
    if @note.save
      flash.now[:success] = "Nice one!"
      redirect_to root_url
    else
      flash.now[:alert] = "Oops! Say something before submitting."
      redirect_to root_url
    end
  end

  def show
    @note = Note.first
  end

  private

    def note_params
      params.require(:note).permit(:title, :content, :university, :class_subject, :professor)
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      redirect_to root_url if @note.nil?
    end
end
