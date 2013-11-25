class City < ActiveRecord::Base

	attr_accessible :country, :name, :street, :home, :apartment

	has_many :users
end