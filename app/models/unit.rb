class Unit < ActiveRecord::Base
  has_many :rooms
  has_many :photos, as: :photographable

  validates :name, presence: true, uniqueness: true

  def preview_images
    []
  end

  def visible_rooms
    rooms.reject &:hidden
  end
end
