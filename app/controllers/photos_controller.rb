class PhotosController < ApplicationController
  def create
    root = if params[:room_id]
      Room.find params[:room_id]
    else
      Unit.find params[:unit_id]
    end

    photo = root.photos.new path: params[:photo][:image_url]
    authorize photo
    photo.save!
    render json: photo
  end
end
