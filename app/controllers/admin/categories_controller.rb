class Admin::CategoriesController < Admin::AdminController
  include TheSortableTreeController::Rebuild
  before_filter :tree, except: [:index, :manage, :create]
  before_filter :find_cat, only: [:update, :edit, :destroy, :publish, :unpublish]
  before_filter :seo_category_params, only: [:update, :create]

  def index
    @categories = Category.nested_set.includes(:content).paginate(page: params[:page], per_page: 15)
  end

  def manage
  end

  def new
    @category = Category.nested_set.new
    @content = @category.build_content
  end

  def create
    @category = Category.nested_set.new(params[:category])
      
    if @category.save
      current_user.contents << @category.content
      flash[:notice] = "Категория #{@category.content.name} успешно создана"
      redirect_to [:edit, :admin, @category]
    else
      render 'new'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Информация о категории #{@category.content.name} успешно обновлена"
      redirect_to [:edit, :admin, @category]
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @category.destroy
    flash[:notice] = "Категория - #{@category.content.name} успешно удалена"
    redirect_to admin_categories_path
  end

  def publish
    @category.content.published = true

    if @category.save
      flash[:notice] = "Категория ##{@category.id} успешно опубликована"
    else
      flash[:alert] = 'Опс, что то пошло не так' 
    end
    
    redirect_to [:edit, :admin, @category]
  end

  def unpublish
    @category.content.published = false
    
    if @category.save
      flash[:notice] = "Категория ##{@category.id} успешно снята с публикации"
    else
      flash[:alert] = 'Опс, что то пошло не так'
    end
    
    redirect_to [:edit, :admin, @category] 
  end

  private
    def tree
      @tree = Category.nested_set.all
    end

    def find_cat
      @category = Category.nested_set.find(params[:id])
    end

    def seo_category_params
      params[:category][:content_attributes][:seo] = params[:seo].to_json
    end
end