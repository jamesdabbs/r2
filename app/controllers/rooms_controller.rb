class RoomsController < ApplicationController
  def show
    @room = Room.find params[:id]
    authorize @room
  end

  def update
    @room = RoomForm.new Room.find params[:id]
    authorize @room
    if @room.validate params.require(:room)
      @room.save
      redirect_to room_path(@room), flash: { success: "Room updated" }
    else
      render :show
    end
  end
end
