class CommentsController < ApplicationController

  def create
    @blog = Blog.find params[:blog_id]
    @comment = @blog.comments.new(params.require(:comment).permit(:user_name, :content, :parent_id))
    @comments = @blog.comments
    if @comment.save
      flash[:notice] = "评论成功!"
      redirect_to blog_path(@blog.id)
    else
      flash[:notice] = "评论失败!"
      render file: 'blogs/show'
    end
  end

end