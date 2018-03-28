class BlogsController < ApplicationController

  def show
    @blog = Blog.find params[:id]
    @comments = @blog.comments
    @comment = Comment.new
  end

end