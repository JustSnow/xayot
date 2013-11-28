class Admin::ActionsController < Admin::AdminController
	include TheSortableTreeController::ReversedRebuild
  before_filter :tree, except: [:index, :manage, :create]
	before_filter :find_action, only: [:update, :edit, :destroy, :publish, :unpublish]
	before_filter :seo_action_params, only: [:update, :create]

	def index
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def publish
	end

	def unpublish
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
