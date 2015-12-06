class ManagementController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_management

  private

  def verify_management
    unless current_user.manager?
      redirect_to :root
    end
  end
end
