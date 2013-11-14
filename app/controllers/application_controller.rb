class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_menu

  private
  	def get_menu
  		@menu = Menu.roots.published
  	end
end
