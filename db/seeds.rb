[Room, Unit, Photo].each &:delete_all

def pug
  j = JSON.parse Net::HTTP.get URI "http://pugme.herokuapp.com/random"
  j["pug"]
end

units = [
  [26, "E", 3],
  [6,  "B", 1],
  [12, "B", 1],
  [17, "B", 1],
  [20, "B", 1],
  [21, "B", 1],
  [23, "B", 1]
]

units.each do |number, last_room, baths|
  rooms = ("A" .. last_room).to_a
  bandb = "#{rooms.count} br / #{baths} bath"

  unit = Unit.create! \
    name:           "##{number}",
    beds_and_baths: bandb,
    description:    Faker::Lorem.paragraph

  rand(2..4).times do
    unit.photos.create! path: pug, description: Faker::Lorem.paragraph
  end

  rooms.each do |letter|
    room = unit.rooms.create! \
      name:         "Unit #{letter}",
      description:  Faker::Lorem.paragraph,
      available_on: rand(-2 .. 11).months.from_now + rand(-10 .. 10).days,
      rent:         "$#{rand(30 .. 42) * 50}"


    rand(2..4).times do
      room.photos.create! path: pug, description: Faker::Lorem.paragraph
    end
  end
end

admin = User.create! \
  email:    "jamesdabbs@gmail.com",
  name:     "James Dabbs",
  password: "password",
  deployer: true
Unit.find_each { |u| admin.managed_units << u }
