class Admin::GalleryPostsController < Admin::AdminController
  before_filter :find_post

  def index
    @gallery = @post.gallery_posts

    respond_to do |format|
      format.html {}
      format.json { render json: @gallery.map{|gallery| gallery.to_jq_upload(@post) } }
    end
  end

  def new
    @gallery = @post.gallery_posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  def create
    p_attr = params[:gallery_post]
    p_attr[:image] = params[:gallery_post][:image].first if params[:gallery_post][:image].class == Array
    @gallery = @post.gallery_posts.build(params[:gallery_post])
    
    respond_to do |format|
      if @gallery.save
        format.html { render json: [@gallery.to_jq_upload(@post)].to_json, content_type: 'text/html', layout: false }
        format.json { render json: [@gallery.to_jq_upload(@post)].to_json, status: :created, location: 'image_url' }
      else
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gallery = @post.gallery_posts.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = "Изображение - #{@gallery.id} успешно удалено"
        redirect_to admin_post_gallery_posts_path @post
      }
      format.json { head :no_content }
    end
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end
end