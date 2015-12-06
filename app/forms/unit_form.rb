class Reform::Form
  def self.validators_on name
    validator._validators[name]
  end
end

class UnitForm < Reform::Form
  property :name
  property :baths
  property :description

  validates :name, presence: true
  validates :baths, presence: true

  collection :photos do
    property :path
    property :description
  end

  collection :rooms do
    property :name
    property :description

    validates :name, presence: true

    collection :photos do
      property :path
      property :description
    end
  end
end
