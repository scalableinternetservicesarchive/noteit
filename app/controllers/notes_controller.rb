class NotesController < ApplicationController
  before_action :authenticate_user!
  #respond_to :html, :js

  def index
    @notes = current_user.notes.paginate(page: params[:page])
  end

  def new
  end

  def create
  	 @note = current_user.notes.build(note_params)
    if @note.save
      #flash.now[:success] = "Nice one!"
      #flash.keep(:success)
      redirect_to root_url
      #render :js => "window.location = '#{note_path(@note)}"
      #respond_to do |format|
       # format.html { redirect_to note_path @note } 
        #format.json { }
      #end
    
    else
      #flash.now[:alert] = "Oops! Say something before submitting."
      #flash.keep(:alert)
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
