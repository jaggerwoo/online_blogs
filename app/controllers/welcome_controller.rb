class WelcomeController < ApplicationController
  
  def index
    @tags = Tag.all.distinct
    @blogs = Blog.order('id desc').page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

  def search_blog
    find_tag = Tag.find params[:tag_id]
    @blogs = find_tag.blogs.order('id desc').page(params[:page] || 1).per_page(params[:per_page] || 10)
    @tags = Tag.all.distinct
  end

end
