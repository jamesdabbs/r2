class Photo < ActiveRecord::Base
  belongs_to :photographable, polymorphic: true

  validates_presence_of :photographable, :path
end
