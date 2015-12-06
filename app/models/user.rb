class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tenants

  has_many :managers
  has_many :managed_units, through: :managers, source: :unit

  def manager?
    managers.any?
  end
end
