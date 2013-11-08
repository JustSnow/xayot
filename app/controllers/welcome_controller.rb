class WelcomeController < ApplicationController
	def index
		@main_category = Content.where("alias = ?", 'main-sidebar').published.first.node
	end
end