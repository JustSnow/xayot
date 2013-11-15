class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, 
  								:first_name, :last_name, :description, :contacts

  has_many :contents, dependent: :destroy
  has_many :menu, dependent: :destroy

  def role
    self[:role].inquiry
  end
end
