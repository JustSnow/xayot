class Post < ActiveRecord::Base
  default_scope order('id desc')
  scope :published, -> { joins(:content).merge(Content.published) }
  scope :main_page, -> { where('main = ?', true) }

  after_save :set_main_page

  has_one :content, as: :node, dependent: :destroy
  belongs_to :category
  has_many :gallery_posts, dependent: :destroy
  has_one :menu

  accepts_nested_attributes_for :content
  attr_accessible :content_attributes, :category_id, :intro, :full, :main

  private
  	def set_main_page
  		Post.where('id != ? AND main = ?', self.id, true).first.update_column('main', false) if (Post.main_page.count > 1 && self.main)
  	end
end
