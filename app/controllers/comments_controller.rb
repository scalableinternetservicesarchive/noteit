class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @note = Note.find_by_id(params[:id])
      @comment = @note.build(:comment)  
      if @comment.save
        flash[:success] = "Comment created"
      else
        flash[:error] = "Error creating comment"
      end
          redirect_to @note

  
  end
  
  private
    
  def comment_params
    params.require(:comment).permit(:content)
  end
end
