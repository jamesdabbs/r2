class PhotoPolicy < ApplicationPolicy
  def create?
    user && user.deployer?
  end
end
