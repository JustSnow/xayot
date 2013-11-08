class Category < ActiveRecord::Base
  default_scope {order('id desc')}
  scope :published, -> { joins(:content).merge(Content.published) }
  
  include TheSortableTree::Scopes
  acts_as_nested_set

  has_one :content, as: :node, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :menu

  accepts_nested_attributes_for :content
  attr_accessible :content_attributes, :parent_id, :lft, :rgt, :depth
end