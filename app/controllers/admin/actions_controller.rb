class Admin::ActionsController < Admin::AdminController
	include TheSortableTreeController::ReversedRebuild
  before_filter :tree, except: [:index, :manage, :create]
	before_filter :find_action, only: [:update, :edit, :destroy, :publish, :unpublish]
	before_filter :seo_action_params, only: [:update, :create]

	def index
		@actions = Action.reversed_nested_set.paginate(page: params[:page], per_page: 15)
	end

	def new
		@action = Action.new
	end

	def create
		@action = current_user.actions.build params[:action]

		if @action.save
			flash[:notice] = "Мероприятие '#{@action.title}' успешно создано"
			redirect_to [:edit, :admin, @action]
		else
			flash[:alert] = 'Ошибка создания'
			render 'new'
		end
	end

	def edit
	end

	def update
		if @action.update_attributes params[:action]
			flash[:notice] = "Мероприятие '#{@action.title}' успешно обновлено"
		else
			flash[:alert] = 'Ошибка обновления'
		end

		redirect_to [:edit, :admin, @action]
	end

	def destroy
		@action.destroy
		flash[:notice] = "Мероприятие '#{@action.title}' успешно удалено"
		redirect_to [:admin, :actions]
	end

	def publish
		@action.published = true

		if @action.save
			flash[:notice] = "Мероприятие '#{@action.title}' успешно опубликовано"
		else
			flash[:alert] = 'Опс, что то пошло не так'
		end

		redirect_to [:edit, :admin, @action]
	end

	def unpublish
		@action.published = false

		if @action.save
			flash[:notice] = "Мероприятие '#{@action.title}' успешно снято с публикации"
		else
			flash[:alert] = 'Опс, что то пошло не так'
		end

		redirect_to [:edit, :admin, @action]
	end

	def manage
  end

	private
		def tree
      @tree = Action.nested_set.all
    end

    def find_action
    	@action = Action.find params[:id]
    end 

    def seo_action_params
      params[:action][:seo] = params[:seo].to_json
    end
end
