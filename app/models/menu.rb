class Menu < ActiveRecord::Base
	default_scope { order('id desc') }
	scope :published, -> { where('published = ?', true) }

	include TheSortableTree::Scopes
  acts_as_nested_set

  belongs_to :post
  belongs_to :category

  attr_accessible :parent_id, :lft, :rgt, :depth, :name, :published, :post_id, :category_id

  validates_presence_of :name
end