class PostsController < ApplicationController
	add_breadcrumb "Главная", :root_path
	
	def index
	end

	def show
		@post = Post.find(params[:id])

		add_breadcrumb @post.category.content.name, @post.category
		add_breadcrumb @post.content.name, @post
	end
end