class PreviewController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @units = Unit.all.
             includes(:photos, rooms: [:photos]).
             select { |u| u.visible_rooms.any? }
    render :index, layout: "preview"
  end

  def deploy
    authorize :preview, :deploy?
    DeployJob.perform_later preview_url
    redirect_to :back, notice: "Deploy started!"
  end
end
