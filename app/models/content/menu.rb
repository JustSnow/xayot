class Menu < ActiveRecord::Base
	scope :published, -> { where('published = ?', true) }

	include TheSortableTree::Scopes
  acts_as_nested_set

  belongs_to :post
  belongs_to :category
  belongs_to :user

  attr_accessible :parent_id, :lft, :rgt, :depth, :name, :published, :post_id, :category_id

  validates_presence_of :name
end