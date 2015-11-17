class NotesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :search]
  respond_to :json, :html


  def search
    if user_signed_in?
      @notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
    end
    @query = Note.search do
        fulltext params[:search]
    end
    @keyword = params[:search]
    @notes = @query.results
  end


  def index
    @notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
    @notes = current_user.notes.paginate(page: params[:page])
  end


  def new
    @notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
  end

  def destroy
    Note.find(params[:id]).destroy
    flash[:success] = "Note deleted"
    redirect_to root_url
  end


  def create
    # updated notes if the note id is already existed
    if Note.find(params[:id])
      @note = Note.find(params[:id])
      @note.title = param[:note][:title]
      @note.content = param[:note][:content]
      @note.university = param[:note][:university]
      @note.notebook_id = param[:note][:notebook_id]
      @note.class_subject = param[:note][:class_subject]
      @note.professor = param[:note][:professor]

    else
    	 @note = current_user.notes.build(note_params)
      if @note.save
        #flash.now[:success] = "Nice one!"
        #flash.keep(:success)
        #redirect_to root_url
        #render :js => "window.location = '#{note_path(@note)}"
        respond_to do |format|
          format.html {render nothing: true, status: 200} 
          format.json {render nothing: true, status: 200} 
        end
      
      else
        #flash.now[:alert] = "Oops! Say something before submitting."
        #flash.keep(:alert)
        respond_to do |format|
          format.html {render nothing: false, status: 400} 
          format.json {render nothing: false, status: 400}
        end
      end
    end
  end
  


  # edit notes
  def edit
    @notebooks = current_user.notebooks if stale?(current_user.notebooks.all)
    @note = Note.find(params[:id])
  end



  def update
    @note = Note.find(params[:id])

    if(params[:upvote])
      @note.upvote_by current_user
      @vote_type = :upvote
      flash.now[:success] = "Upvoted!"
      respond_to do |format|
        format.html { redirect_to @note }
        format.js
      end

    elsif(params[:downvote])
      @note.downvote_by current_user
      flash.now[:alert] = "Downvoted!"
      @vote_type = :downvote
      respond_to do |format|
        format.html { redirect_to @note }
        format.js
      end
    end 


  end


  def show
    #@notebooks = current_user.notebooks if user_signed_in?
    @note = Note.find(params[:id])
    @comments = @note.comments if stale?(@note.comments.all)
    if(user_signed_in?)
      @note_owner = @note.user_id
    else
      @note_owner = -1
    end
  end

  def upload_note
    @note = current_user.notes.build(upload_note_params)
    if @note.save
        flash[:success] = "Saved successfully!" 
        redirect_to notes_path
    else
      flash[:error] = "Save unsuccessful. Please make sure all three fields have a value!"
      redirect_to static_pages_home_path
    end

  end

  def create_comment
    @note = Note.find(params[:id])
    @comment = current_user.comments.build(create_comment_params)
    if @comment.save
      @comment.update_attribute(:note_id, '#{@note.id}')
      flash[:success] = "Comment posted successfully!" 
      redirect_to @note
    else
      flash[:alert] = "Sorry, something went wrong. Please try again." 
      redirect_to @note
    end
  end

  private
    def create_comment_params
      params.require(:note).permit(:content)
    end
    def upload_note_params
      params.require(:note).permit(:title, :content, :notebook_id, :avatar)
    end

    def note_params
      params.require(:note).permit(:title, :content, :university, :notebook_id, :class_subject, :professor, :tags)
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      redirect_to root_url if @note.nil?
    end
end
