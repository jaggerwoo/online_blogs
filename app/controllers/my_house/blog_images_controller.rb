class MyHouse::BlogImagesController < MyHouse::BaseController
  skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]
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

  def destroy
    @blog_image = @blog.blog_images.find params[:id]
    if @blog_image.destroy
      flash[:notice] = "删除成功!"
    else
      flash[:notice] = "删除失败!"
    end
    redirect_to :back
  end

  private

    def find_blog_id
      @blog = Blog.find params[:blog_id]
    end
end