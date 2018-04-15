class BlogsController < ApplicationController

  def show
    @blog = Blog.find params[:id]
    @blog_images = @blog.blog_images
    @blog_tags = @blog.tags
    @comments = @blog.comments
    @comment = Comment.new
  end

end