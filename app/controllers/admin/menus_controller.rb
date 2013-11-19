class Admin::MenusController < Admin::AdminController
	# include TheSortableTreeController::Rebuild
	include TheSortableTreeController::ReversedRebuild
  before_filter :tree, except: [:index, :manage, :create]
	before_filter :find_menu, except: [:index, :new, :create, :rebuild_select]

	def index
		# @menus = Menu.nested_set.paginate(page: params[:page], per_page: 15)
		@menus = Menu.reversed_nested_set.paginate(page: params[:page], per_page: 15)
	end

	def manage
  end

  def rebuild_select
  	@link = case params[:link_menu]
	  	when 'category' then Category.all
	  	when 'post' then Post.all
  	end
  end

	def new
		@menu = current_user.menu.build
	end

	def create
		@menu = current_user.menu.build(params[:menu])

		if @menu.save
			flash[:notice] = "Меню - #{@menu.name} успешно создано"
			redirect_to [:edit, :admin, @menu]
		else
			flash[:alert] = "При сохранении возникли ошибки"
			render 'new'
		end

	end

	def edit
	end

	def update
		params[:menu][:post_id] = nil if params[:menu][:category_id].present?
		params[:menu][:category_id] = nil if params[:menu][:post_id].present?

		if @menu.update_attributes(params[:menu])
			flash[:notice] = "Пункт меню - #{@menu.name} успешно обновлен"
			redirect_to [:edit, :admin, @menu]
		else
			render 'edit'
		end
	end

	def destroy
		@menu.destroy
		flash[:notice] = "Пункт меню - #{@menu.name} успешно удален"
		redirect_to admin_menus_path
	end

	def publish
		if @menu.update_column(:published, true)
			flash[:notice] = "Пункт меню - #{@menu.name} успешно опубликован"
		else
			flash[:alert] = "Что то пошло не так"
		end

		redirect_to admin_menus_path
	end

	def unpublish
		if @menu.update_column(:published, false)
			flash[:notice] = "Пункт меню - #{@menu.name} успешно снят с публикации"
		else
			flash[:alert] = "Что то пошло не так"
		end

		redirect_to admin_menus_path
	end

	private
		def find_menu
			@menu = Menu.find(params[:id])
		end

		def tree
      @tree = Category.nested_set.all
    end
end