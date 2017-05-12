class MyHouse::BlogImagesController < MyHouse::BaseController
  before_action :find_blog_id

  def index
    @blog_images = @blog.blog_images
  end

  def create
    params[:images].each do |image|
      @blog.blog_images << BlogImage.new(image: image)
    end
    redirect_to :back
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def find_blog_id
    @blog = Blog.find params[:blog_id]
  end
end