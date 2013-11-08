class Admin::PostsController < Admin::AdminController
  before_filter :find_post, only: [:update, :edit, :destroy, :publish, :unpublish]
  before_filter :seo_post_params, only: [:update, :create]

  def index
    @posts = Post.includes(:content).paginate(page: params[:page], per_page: 15)
  end

  def new
    @post = Post.new
    @content = @post.build_content
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      current_user.contents << @post.content
      flash[:notice] = "Пост '#{@post.content.name}' успешно создан"
      redirect_to [:edit, :admin, @post] 
    else
      render 'new'
    end
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Информация о посте '#{@post.content.name}' успешно обновлена"
      redirect_to [:edit, :admin, @post] 
    else
      render 'edit'
    end
  end

  def edit
  end

  def publish
    @post.content.published = true

    if @post.save
      flash[:notice] = "Пост ##{@post.id} успешно опубликован"
      redirect_to admin_posts_path 
    else
      flash[:alert] = 'Опс, что то пошло не так'
      redirect_to [:edit, :admin, @post]
    end
  end

  def unpublish
    @post.content.published = false
    
    if @post.save
      flash[:notice] = "Пост ##{@post.id} успешно снят с публикации"
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Опс, что то пошло не так'
      redirect_to [:edit, :admin, @post]
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Пост ##{@post.id} - '#{@post.content.name}' успешно удален"
    redirect_to admin_posts_path
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def seo_post_params
      params[:post][:content_attributes][:seo] = params[:seo].to_json
    end
end