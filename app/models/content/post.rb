class Post < ActiveRecord::Base
  scope :published, -> { joins(:content).merge(Content.published) }
  scope :main_page, -> { where('main = ?', true) }
  scope :order_desc, -> { order('id DESC') }

  has_one :content, as: :node, dependent: :destroy
  belongs_to :category
  has_many :gallery_posts, dependent: :destroy
  has_one :menu, dependent: :destroy

  accepts_nested_attributes_for :content
  attr_accessible :content_attributes, :category_id, :intro, :full, :main#, :video

  after_save :set_main_page
  validate :supported_video_url

  def embed_video w = 555, h = 420
    UnvlogIt.new(video).embed_html(w, h)
  rescue OpenURI::HTTPError, ArgumentError
  end

  private
    def set_main_page
      Post.where('id != ? AND main = ?', self.id, true).first.update_column('main', false) if (Post.main_page.count > 1 && self.main)
    end

    def supported_video_url
      UnvlogIt.new(video) if video?
    rescue ArgumentError
      # errors.add :video, I18n.t('activerecord.errors.models.gift.unsuported_url')
    end
end
