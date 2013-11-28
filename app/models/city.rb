class City < ActiveRecord::Base
	scope :order_desc, -> { order('id DESC') }

	attr_accessible :country, :name, :street, :home, :apartment

	has_many :users
	has_many :actions, dependent: :destroy

	validates_presence_of :name
end