class Room < ActiveRecord::Base
  belongs_to :unit
  has_many :photos, as: :photographable

  validates :name, presence: true, uniqueness: { scope: :unit }

  #def photos
  #  ["http://placehold.it/200x100"] * 3
  #end
end
