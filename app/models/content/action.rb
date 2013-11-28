class Action < ActiveRecord::Base
	scope :order_desc, -> { order('id DESC') }
	scope :published, -> { where(published: true) }

	include TheSortableTree::Scopes
	acts_as_nested_set
	
	belongs_to :city
	belongs_to :user
end