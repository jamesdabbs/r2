class PreviewPolicy < ApplicationPolicy
  def deploy?
    user && user.deployer?
  end
end
