class RoomPolicy < ApplicationPolicy
  def update?
    user && user.managed_units.include?(record)
  end
end
