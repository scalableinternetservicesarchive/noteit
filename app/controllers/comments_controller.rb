class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def create
    #@note = Note.find(params[:note_id])
    @comment = current_user.comments.build(create_comment_params)
    @comment.note_id = params[:note_id]
    if @comment.save
      flash[:success] = "Comment posted successfully!" 
      redirect_to Note.find(params[:note_id])
    else
      flash[:alert] = "Please make sure of the comment body." 
      redirect_to Note.find(params[:note_id])
    end
  end

  def show
    @note = Note.find(params[:note_id])
    @comments = @note.comments
  end
 
 private
 	def create_comment_params
      params.require(:comment).permit(:body)
 	end
end
