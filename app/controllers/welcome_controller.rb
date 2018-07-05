class WelcomeController < ApplicationController
  
  def index
    @tags = Tag.all.distinct
    @blogs = Blog.order('id desc').page(params[:page] || 1).per_page(params[:per_page] || 9)
  end

  def search_blog
    find_tag = Tag.find params[:tag_id]
    @blogs = find_tag.blogs.order('id desc').page(params[:page] || 1).per_page(params[:per_page] || 9)
    @tags = Tag.all.distinct
  end

  def search
    search_field = params[:w].present? ? params[:w] : "*"
    @blogs = Blog.search search_field, fields: [:title, :content], page: params[:page], per_page: 9, order: {id: :desc}, operator: "or"
    p '========'
    p @blogs
    #@blogs = Blog.where("title like :title", title: "%#{params[:w]}%").order('id desc').page(params[:page] || 1).per_page(params[:per_page] || 9)
    @tags = Tag.all.distinct
    render action: :index
  end

end
