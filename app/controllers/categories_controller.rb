class CategoriesController < ApplicationController
	add_breadcrumb "Главная", :root_path

	def index
	end

	def show
		@category = Category.find(params[:id])
		@posts = @category.posts.paginate(page: params[:page], per_page: 15)

		add_breadcrumb @category.content.name, @category
	end
end