class User < ActiveRecord::Base
	has_many :news
	has_many :comments

	belongs_to :user_type

	belongs_to :province

	before_create :set_columns
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  def provincial_last
  	News.joins(user: :province).where("provinces.id = '#{self.province.id}'")
  end

  def regional_last
  	News.joins(user: { province: :region }).where("regions.id = '#{self.province.region.id}'")
  end

  def set_columns
  	self.status = true
  	self.user_type ||= UserType.where(code: 'G')
  end
end
