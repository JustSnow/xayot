class Action < ActiveRecord::Base
	scope :order_desc, -> { order('id DESC') }

	include TheSortableTree::Scopes
	acts_as_nested_set
	
	belongs_to :city
end