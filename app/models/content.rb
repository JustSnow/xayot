class Content < ActiveRecord::Base
  scope :published, -> { where(published: true) }

  belongs_to :node, polymorphic: true
  belongs_to :user

  attr_accessible :name, :alias, :seo, :published, :user_id, :image
  
  validates_presence_of :name
  
  before_validation :set_alias

  mount_uploader :image, ImageUploader

  def set_alias
    if self.alias.blank?
      if self.name?
        translite_alias = Russian.translit(self.name)
        self.alias = translite_alias.gsub(' ','-').gsub(/[^\x00-\x7F]+/, '').gsub(/[^\w_ \-]+/i,'').gsub(/[ \-]+/i,'-').gsub(/^\-|\-$/i,'').downcase
      end
    else
      self.alias = self.alias.gsub(' ','-').gsub(/[^\x00-\x7F]+/, '').gsub(/[^\w_ \-]+/i,'').gsub(/[ \-]+/i,'-').gsub(/^\-|\-$/i,'').downcase
    end
  end
end