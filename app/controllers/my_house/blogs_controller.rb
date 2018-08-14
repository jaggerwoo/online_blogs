class MyHouse::BlogsController < MyHouse::BaseController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_action :find_blog_id, except: [:new, :create, :index]
  
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params.require(:blog).permit(:title, :content, :is_public, :tags_string))
    if @blog.save
      flash[:notice] = "创建成功!"
      redirect_to my_house_root_path
    else
      flash[:notice] = "创建失败!"
      render action: :new
    end
  end

  def index
    @blogs = Blog.page(params[:page] || 1).per_page(params[:per_page] || 10).order("id desc")
  end

  def show
    
  end

  def edit
    render action: :new
  end

  def update
    @blog.attributes = params.require(:blog).permit(:title, :content, :is_public, :tags_string)
    if @blog.save
      flash[:notice] = "修改成功!"
      redirect_to my_house_root_path
    else
      flash[:notice] = "修改失败!"
      render action: :new
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = "删除成功!"
    redirect_to my_house_root_path
  end

  private
  def find_blog_id
    @blog = Blog.find params[:id]
  end
end