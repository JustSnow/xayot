class WelcomeController < ApplicationController
	def index
		@main_category = Content.where("alias = ?", 'main-sidebar').published.first.node
		@main_post = Post.main_page.first
		@news = Content.where('alias = ?', 'news').first.node
	end
end