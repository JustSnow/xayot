class Content < ActiveRecord::Base
  scope :published, -> { where(published: true) }

  belongs_to :node, polymorphic: true
  belongs_to :user

  attr_accessible :name, :alias, :seo, :published, :user_id, :image
  
  validates_presence_of :name
  
  before_validation :set_alias, if: -> { self.alias.blank? }

  mount_uploader :image, ImageUploader

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