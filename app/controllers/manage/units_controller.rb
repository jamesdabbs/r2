class Manage::UnitsController < ManagementController
  def index
    @units = current_user.managed_units
  end
end
