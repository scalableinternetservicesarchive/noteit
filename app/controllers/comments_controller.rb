class CommentsController < ApplicationController
  def create
    @note = Note.find_by_id(params[:note_id])
    @comment = @note.comments.create!(comment_params)
    redirect_to @note  
  end
  
  private
    
  def comment_params
    params.require(:comment).permit(:body)
  end
end
