class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.post_id = @post.id
    render :error unless @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
