class CategoriesController < ApplicationController
	add_breadcrumb "Главная", :root_path

	def index
	end

	def show
		@category = Category.find(params[:id])
		add_breadcrumb @category.content.name, @category
	end
end