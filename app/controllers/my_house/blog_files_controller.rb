class MyHouse::BlogFilesController < MyHouse::BaseController
  skip_before_filter :verify_authenticity_token, :only => [:create, :destroy, :download_file]
  before_action :find_blog_id, except: [:download_file]

  def index
    @blog_files = @blog.blog_files
  end

  def create
    params[:files].each do |file|
      @blog.blog_files << BlogFile.new(attachment_file: file)
    end
    redirect_to :back
  end

  def destroy
    @blog_file = @blog.blog_files.find params[:id]
    if @blog_file.destroy
      flash[:notice] = "删除成功!"
    else
      flash[:notice] = "删除失败!"
    end
    redirect_to :back
  end

  def download_file
    @attachment = BlogFile.find(params[:id])

    send_file(@attachment.attachment_file.file.path, disposition: 'inline')
  end

  private
  def find_blog_id
    @blog = Blog.find params[:blog_id]
  end
end