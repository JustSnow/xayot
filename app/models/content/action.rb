class Action < ActiveRecord::Base
	scope :order_desc, -> { order('id DESC') }
	scope :published, -> { where(published: true) }

	include TheSortableTree::Scopes
	acts_as_nested_set

	mount_uploader :image, ImageUploader
	
	belongs_to :city
	belongs_to :user
	belongs_to :category

  before_validation :set_alias, if: -> { self.alias.blank? }
	validates_presence_of :name

	private
    def set_alias
      self.alias = filter_gsub Russian.translit(self.name)
    end

    def filter_gsub str
      str_g = str.gsub(' ','-')
              .gsub(/[^\w_ \-]+/i,'')
              .gsub(/[ \-]+/i,'-')
              .gsub(/^\-|\-$/i,'')
              .downcase
      str_g
    end
end