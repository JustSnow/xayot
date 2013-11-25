class City < ActiveRecord::Base
	scope :order_desc, -> { order('id DESC') }

	attr_accessible :country, :name, :street, :home, :apartment

	has_many :users

	validates_presence_of :name
end